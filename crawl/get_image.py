from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus
import ssl
import psycopg2


# db에 접속
conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
cur = conn.cursor() # 커서 생성

sql = "SELECT original_title FROM _MOVIE LIMIT 1;"
cur.execute(sql);
movieData = cur.fetchone()

def getImg():
    ssl._create_default_https_context = ssl._create_unverified_context
    context = ssl._create_unverified_context()
    baseQueryUrl = 'https://www.themoviedb.org/search?language=ko-KR&query='
    baseUrl = "https://www.themoviedb.org"
    plusUrl = movieData[0]
    crawl_num = 1
    # 한글 검색 자동 변환
    url = baseQueryUrl + quote_plus(plusUrl)
    html = urlopen(url)
    soup = bs(html, "html.parser")
    img = soup.find("div", class_= "poster")
    posterUrl = img.find("a")["href"]
    posterUrl = baseUrl + posterUrl
    html = urlopen(posterUrl)
    soup = bs(html, "html.parser") 
    div = soup.find("div", class_= "image_content backdrop")
    img = div.find("img")["data-src"]
    img = img[1: : ]
    img = img[1: : ]
    img = "http://" + img
    print(img)

getImg()

