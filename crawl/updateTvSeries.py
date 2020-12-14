import psycopg2
import ssl
from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus

def getImg(title):
    ssl._create_default_https_context = ssl._create_unverified_context
    context = ssl._create_unverified_context()
    baseQueryUrl = 'https://www.themoviedb.org/search/tv?language=ko&query='
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
        div = soup.find("div", class_= "image_content backdrop")
        if div != None and div.find("img"):
            img = div.find("img")["data-src"]
            img = img[1: : ]
            img = img[1: : ]
            img = "http://" + img
            return img
        else:
            return None
    else:
        return None

# db에 접속
conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
cur = conn.cursor() # 커서 생성
ssl._create_default_https_context = ssl._create_unverified_context


sql = "SELECT Original_title, date_part('year',start_year), Movie_id FROM MOVIE WHERE Type = 'tvSeries';"
cur.execute(sql)
res = cur.fetchall()
for m in res:
    title = m[0]
    year = int(m[1])
    search = title
    image = getImg(search)
    if image:
        sql = "UPDATE MOVIE SET post_image = '" + image + "' WHERE Movie_id = " + str(m[2]) + ";"
    else:
        sql = "UPDATE MOVIE SET post_image = 'https://everyfad.com/static/images/movie_poster_placeholder.29ca1c87.svg' WHERE Movie_id = " + str(m[2]) + ";" 
    cur.execute(sql)
    conn.commit() 
    print(title)
    print(image)
