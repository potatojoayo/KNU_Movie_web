import psycopg2
import ssl
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus

def getImg(name):
    ssl._create_default_https_context = ssl._create_unverified_context
    context = ssl._create_unverified_context()
    baseQueryUrl = 'https://www.imdb.com/find?s=nm&ref_=nv_sr_sm&q='
    baseUrl = "https://www.imdb.com/"
    plusUrl = name
    crawl_num = 1
    # 한글 검색 자동 변환
    url = baseQueryUrl + quote_plus(plusUrl)
    html = urlopen(url)
    soup = bs(html, "html.parser")
    img = soup.find("td", class_= "result_text")
    if img:
        posterUrl = img.find("a")["href"]
        posterUrl = baseUrl + posterUrl
        html = urlopen(posterUrl)
        soup = bs(html, "html.parser") 
        div = soup.find("div", class_= "image")
        if div != None and div.find("img"):
            img = div.find("img")["src"]
            return img
        else:
            return None
    else:
        return None

# db에 접속
conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
cur = conn.cursor() # 커서 생성
ssl._create_default_https_context = ssl._create_unverified_context

for i in range(1,2597):
    sql = "SELECT Actor_name FROM ACTOR WHERE Actor_id = " + str(i) + ";"
    cur.execute(sql)
    name = cur.fetchone()[0]
    image = getImg(name)
    if image:
        sql = "UPDATE ACTOR SET profile_image = '" + image + "' WHERE Actor_id = " + str(i) + ";"
    else:
        sql = "UPDATE ACTOR SET profile_image = 'https://www.pinclipart.com/picdir/middle/25-259252_special-school-nurse-person-placeholder-image-png-clipart.png' WHERE Actor_id = " + str(i) + ";" 
    cur.execute(sql)
    conn.commit() 
    print(name)
