import psycopg2
import ssl
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus
from dataclasses import dataclass
from datetime import date

#-*-coding:utf-8-*-
@dataclass
class Director:
    name: str = None
    profile: str = None
    birthDay: str = None
    passedDay: str = None


def getDirector(title):
    ssl._create_default_https_context = ssl._create_unverified_context
    context = ssl._create_unverified_context()
    baseQueryUrl = 'https://www.themoviedb.org/search?language=ko-KR&query='
    baseUrl = "https://www.themoviedb.org"
    plusUrl = title
    crawl_num = 1
    url = baseQueryUrl + quote_plus(plusUrl)
    html = urlopen(url)
    soup = bs(html, "html.parser")
    img = soup.find("div", class_= "poster")
    director = Director()
    if img is not None:
        posterUrl = img.find("a")["href"]
        posterUrl = baseUrl + posterUrl
        html = urlopen(posterUrl)
        soup = bs(html, "html.parser") 
        ol = soup.find("ol", class_= "people no_image")
        if ol==None:
            return None

        # fetch name of director
        if ol.find("a")==None:
            return None
        name = ol.find("a").get_text()
        name = name.replace("'", "`")
        director.name = name

        directorUrl = baseUrl + ol.find("a")["href"]
        html = urlopen(directorUrl)
        soup = bs(html, "html.parser")
        div = soup.find("div", class_="image_content")
        if div is not None:
            if div.find("img") is not None:
                profile = div.find("img")["data-src"]
                profile = profile[1: : ]
                profile = profile[1: : ]
                director.profile = "http://" + profile 
            else: 
                director.profile = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png" 

            section = soup.find("section", class_="full_wrapper facts left_column")
            ps = section.find_all("p", class_="full")
            for p in ps:
                if p.find("bdi").get_text()=="생일": 
                    bday = p.get_text()
                    bday = bday.replace("\n","")
                    bday = bday.replace(" ","") 
                    bdate = bday[2:12]
                    if len(bdate) <10:
                        bdate = '1999-01-01'
                    director.birthDay = bdate
                elif p.find("bdi").get_text()=="사망일": 
                    dday = p.get_text()
                    dday = dday.replace("\n","")
                    dday = dday.replace(" ","") 
                    ddate = dday[3:13]
                    director.passedDay = ddate 
            return director 
    else:
        return None


# db에 접속
conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
ssl._create_default_https_context = ssl._create_unverified_context 
cur = conn.cursor() # 커서 생성

for i in range(1387,1680):
    sql = "SELECT Original_title, Movie_id, date_part('year', start_year) FROM MOVIE WHERE Movie_id = " + str(i) + ";"
    cur.execute(sql)
    res = cur.fetchone()
    title = res[0]
    mid = res[1]
    startYear = int(res[2])
    search = title + " y:" + str(startYear)
    print(title + ": " + str(startYear))
    director = getDirector(search)
    if director:
        if director.profile == None:
            director.profile = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png" 
        if director.passedDay != None:
            sql = "INSERT INTO DIRECTOR(name,birth_day, passed_day, profile_image) " \
            + "VALUES('" + director.name + "', '" + str(director.birthDay) + "', '" \
            + str(director.passedDay) + "', '" + director.profile + "') RETURNING Director_id;"
        else:
            sql = "INSERT INTO DIRECTOR(name,birth_day, profile_image) " \
            + "VALUES('" + director.name + "', '" + str(director.birthDay) + "', '" \
            + director.profile + "') RETURNING Director_id;" 
        try:
            cur.execute(sql)
            did = cur.fetchone()[0]
        except psycopg2.IntegrityError as e: 
            conn.rollback()
            sql = "SELECT Director_id FROM DIRECTOR WHERE Name = '" + director.name + "';"
            cur.execute(sql)
            did = cur.fetchone()[0]
        else: 
            conn.commit() 
        
        sql = "INSERT INTO DIRECTOR_OF VALUES (" + str(mid) +", " + str(did) +");"
        try: 
            cur.execute(sql)
            print(director.name)
        except psycopg2.Error as e:
            conn.rollback()
        else:
            conn.commit()
        
