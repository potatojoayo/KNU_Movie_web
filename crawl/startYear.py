import psycopg2
import ssl
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus

def getStartYear(title):
    ssl._create_default_https_context = ssl._create_unverified_context
    context = ssl._create_unverified_context()
    baseQueryUrl = 'https://www.themoviedb.org/search?language=ko-KR&query='
    baseUrl = "https://www.themoviedb.org"
    plusUrl = title
    crawl_num = 1
    # 한글 검색 자동 변환
    url = baseQueryUrl + quote_plus(plusUrl)
    html = urlopen(url)
    soup = bs(html, "html.parser")
    img = soup.find("div", class_= "poster")
    if img:
        posterUrl = img.find("a")["href"]
        posterUrl = baseUrl + posterUrl
        html = urlopen(posterUrl)
        soup = bs(html, "html.parser") 
        span = soup.find("span", class_= "release")
        if span != None:
            date = span.get_text() 
            date = date.replace("\n","")
            date = date.replace(" ","")
            date = date.replace("/","-")
            date = date[0:10]
            print(date)
            return date
        else:
            return None
    else:
        return None


conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
cur = conn.cursor() # 커서 생성
ssl._create_default_https_context = ssl._create_unverified_context

for i in range(1,1680):
    sql = "SELECT Original_title FROM MOVIE WHERE Movie_id = " + str(i) + ";"
    cur.execute(sql)
    title = cur.fetchone()[0]
    date = getStartYear(title)
    if date:
        sql = "UPDATE MOVIE SET start_year = '" + date + "' WHERE Movie_id = " + str(i) + ";"
    try:
        cur.execute(sql)
        conn.commit() 
        print(title)
    except psycopg2.Error as e:
        print(e)
