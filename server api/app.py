from urllib.request import urlopen
import urllib.request
from bs4 import BeautifulSoup as bs
from urllib.parse import quote_plus
import ssl
import psycopg2
from flask import Flask
from flask import request
from psycopg2.extras import RealDictCursor
import flask
import simplejson as json
from flask_cors import CORS, cross_origin


# db에 접속
conn = psycopg2.connect(host='localhost',dbname='knu', user='knu', password='1234', port = '5432')
conn.set_client_encoding('UTF8')
cur = conn.cursor(cursor_factory=RealDictCursor) # 커서 생성


#유저가 평가한 영화 중 가장 많은 장르의 영화

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content_Type'

@app.route('/')
def index():
    res = flask.Response()
    res.headers.add("Access-Control-Allow-Origin","*")
    res.set_data('knuMovie') 
    return res


@app.route('/movie/recommend/genre', methods=['POST'])
@cross_origin()
def selectRecommendGenre():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "WITH user_ratings AS ( SELECT mid AS Movie_id FROM RATING WHERE uid = 1), most_genre AS (SELECT gen, count(*) FROM MOVIE, GENRE_OF WHERE mid = Movie_id AND Movie_id IN (SELECT Movie_id FROM user_ratings) GROUP BY gen ORDER BY count(*) DESC LIMIT 3) SELECT * FROM MOVIE, GENRE_OF WHERE mid = Movie_id AND gen in (SELECT gen FROM most_genre) AND NOT EXISTS(SELECT * FROM Rating WHERE uid = "+ str(uid) +" AND mid = Movie_id) LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/recommend/director', methods=['POST'])
@cross_origin()
def selectRecommendDirector():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "WITH user_ratings AS (SELECT mid AS Movie_id FROM RATING WHERE uid = "+str(uid)+"), most_drts AS (SELECT did, count(*) FROM MOVIE, DIRECTOR_OF WHERE mid = Movie_id AND Movie_id IN (SELECT Movie_id FROM user_ratings) GROUP BY did ORDER BY count(*) DESC LIMIT 3) SELECT * FROM MOVIE, DIRECTOR_OF WHERE mid = Movie_id AND did in (SELECT did FROM most_drts) AND NOT EXISTS(SELECT * FROM Rating WHERE uid = "+ str(uid) +" AND mid = Movie_id) LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/recommend/actor', methods=['POST'])
@cross_origin()
def selectRecommendActor():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "WITH user_ratings AS (SELECT mid AS Movie_id FROM RATING WHERE uid = "+str(uid)+"), most_actors AS (SELECT aid, count(*) FROM MOVIE, ACTOR_OF WHERE mid = Movie_id AND Movie_id IN (SELECT Movie_id FROM user_ratings) GROUP BY aid ORDER BY count(*) DESC LIMIT 3) SELECT * FROM MOVIE, ACTOR_OF WHERE mid = Movie_id AND aid in (SELECT aid FROM most_actors) AND NOT EXISTS(SELECT * FROM Rating WHERE uid = "+ str(uid) +" AND mid = Movie_id) LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/popular_tv_series', methods=['POST'])
@cross_origin()
def selectTvSeries():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "SELECT DISTINCT Movie.* FROM MOVIE LEFT OUTER JOIN VERSION ON VERSION.mid = Movie_id WHERE " \
            + "NOT EXISTS (SELECT * FROM RATING WHERE mid = Movie_id AND Rating.uid = " + str(uid) +") " \
            + "AND Type = 'tvSeries' AND RATING IS NOT NULL AND Post_image LIKE '%tmdb%' LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/hot-in-korea', methods=['POST'])
@cross_origin()
def selectHotInKorea():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "SELECT Movie.* FROM MOVIE LEFT OUTER JOIN VERSION ON VERSION.mid = Movie_id WHERE " \
            + "NOT EXISTS (SELECT * FROM RATING WHERE mid = Movie_id AND Rating.uid = " + str(uid) +") " \
            + "AND Type != 'tvSeries' AND Region = 'KR' AND RATING IS NOT NULL LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/classic', methods=['POST'])
@cross_origin()
def selectClassic():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "SELECT * FROM MOVIE WHERE NOT EXISTS (SELECT * FROM RATING WHERE mid = Movie_id AND uid = " + str(uid) +") " \
            + " AND Type != 'tvSeries' AND Date_part('year',Start_year) <= 1990 AND RATING IS NOT NULL " \
            + "AND Post_image LIKE '%tmdb%' ORDER BY Rating DESC LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/movie/highest_rating', methods=['POST'])
@cross_origin()
def selectHighestRating():
    res = flask.Response()
    uid = request.form['uid']
    
    sql = "SELECT * FROM MOVIE WHERE NOT EXISTS (SELECT * FROM RATING WHERE mid = Movie_id AND uid = " + str(uid) +") " \
            + " AND Type != 'tvSeries' AND Rating is not null ORDER BY Rating DESC LIMIT 20;"
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/director/select', methods=['POST'])
@cross_origin()
def selectDirector():
    res = flask.Response()
    director = request.form['director']
    if director == None:
        director = '';
    
    sql = "SELECT * FROM Director WHERE LOWER(director_name) LIKE '%" + director + "%';" 
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/actor/select', methods=['POST'])
@cross_origin()
def selectActor():
    res = flask.Response()
    actor = request.form['actor']
    
    sql = "SELECT * FROM ACTOR WHERE LOWER(Actor_name) LIKE '%" + actor + "%';" 
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/genre/select', methods=['POST'])
@cross_origin()
def selectGenre():
    res = flask.Response()
    genre = request.form['genre']
    
    sql = "SELECT * FROM GENRE WHERE LOWER(Genre) LIKE '%" + genre + "%';" 
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res

@app.route('/genre/add', methods=['POST'])
@cross_origin()
def addGenre():
    res = flask.Response()
    genre = request.form['genre']

    sql = "INSERT INTO GENRE(Genre) VALUES (" + genre + ");"
    cur.execute(sql)
    conn.commit()
    
    sql = "SELECT * FROM GENRE WHERE LOWER(Genre) LIKE '%" + genre + "%';" 
    cur.execute(sql) 

    data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str) \
    .encode('utf8')
    res.set_data(data)
    return res


@app.route('/movie/genre', methods=['POST'])
@cross_origin()
def genre():
    res = flask.Response()
    mid = request.form['mid']

    sql = "SELECT Genre FROM GENRE, GENRE_OF WHERE gen = Genre_id AND mid = " + str(mid) + ";"

    try:
        cur.execute(sql)
        data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.set_data(data)
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        return res 
    return res 

@app.route('/movie/actor', methods=['POST'])
@cross_origin()
def actor():
    res = flask.Response()
    mid = request.form['mid']

    sql = "SELECT Actor_name, Profile_image FROM ACTOR, ACTOR_OF WHERE aid = Actor_id AND mid = " + str(mid) + ";"

    try:
        cur.execute(sql)
        data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.set_data(data)
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        return res 
    return res 

@app.route('/admin',methods=['POST'])
@cross_origin()
def admin():
    res = flask.Response()
    uid = request.form['uid']
    sql = "SELECT * FROM ADMIN WHERE uid = " + str(uid) + ";" 
    cur.execute(sql) 
    isAdmin = "True" if cur.rowcount==1 else "False"
    res.set_data(isAdmin)
    return res


@app.route('/movie/update',methods=['POST'])
@cross_origin()
def updateMovie():
    res = flask.Response()
    title = request.form['original_title']
    type = request.form['type']
    isAdult = request.form['is_adult']
    gen = request.form['gen'] 
    startYear = request.form['start_year']
    endYear = request.form['end_year']
    aid = request.form['aid']
    mode = request.form['mode']
    mid = request.form['mid']
    rtime = request.form['running_time']
    region = request.form['region']
    image = request.form['image']
    did = request.form['did']

    if mode == "register":
        sql = "INSERT INTO MOVIE (" + "Original_title, Type, Is_adult, rating)" \
        + "VALUES (" + "'" + title + "', '" + type + "', " + isAdult + ", 0.0) RETURNING Movie_id;" 
        cur.execute(sql) 
        returned = json.dumps(cur.fetchone())
        mid_json = json.loads(returned)
        mid = mid_json['movie_id'] 
    else:
        if title!="null":
            sql = "UPDATE MOVIE SET Original_title = '" + title + "' WHERE Movie_id = " \
            + str(mid) + ";"
            cur.execute(sql) 
        if type!="null":
            sql = "UPDATE MOVIE SET Type = '" + type + "' WHERE Movie_id = " \
            + str(mid) + ";"
            cur.execute(sql) 
        if isAdult != "null":
            sql = "UPDATE MOVIE SET Is_adult = " + isAdult + " WHERE Movie_id = " \
            + str(mid) + ";"
            cur.execute(sql) 
            
    if region != "null": 
        sql = "UPDATE VERSION SET region = '" + region + "' WHERE mid = " + str(mid)+ ";" 
        cur.execute(sql) 
        if cur.rowcount == 0:
            conn.rollback()
            sql = "INSERT INTO VERSION(version_title, mid, region) " \
            + "VALUES ('" + title + "', " + str(mid) + ",  '" + region + "');"
            cur.execute(sql) 



    if image!="null":
        sql = "UPDATE MOVIE SET Post_image = '" + image + "' WHERE Movie_id = " + str(mid) + ";"
        cur.execute(sql) 
    if rtime!="null":
        sql = "UPDATE MOVIE SET Running_time = " + str(rtime) + " WHERE Movie_id = " + str(mid) + ";"
        cur.execute(sql) 
    if startYear!="null":
        sql = "UPDATE MOVIE SET Start_year = '" + startYear + "' WHERE Movie_id = " + str(mid) + ";"
        cur.execute(sql) 
    if endYear!="null":
        sql = "UPDATE MOVIE SET End_year = '" + endYear + "' WHERE Movie_id = " + str(mid) + ";"
        cur.execute(sql) 
    if did!="null" and (mode == "add_director" or mode == "register"):
        sql = "INSERT INTO DIRECTOR_OF(mid,did) VALUES(" + str(mid) + ", " + str(did) + ");" 
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            conn.rollback()
    if did!="null" and mode == "delete_director":
        sql = "DELETE FROM DIRECTOR_OF WHERE mid = " + str(mid) + " AND did = " + str(did) + ";"
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            res.set_data(e.pgerror)
            conn.rollback()
            return res
    if gen!="null" and (mode == "add_genre" or mode == "register"):
        sql = "INSERT INTO GENRE_OF(mid,gen) VALUES(" + str(mid) + ", " + str(gen) + ")"; 
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            conn.rollback()
    if gen!="null" and mode == "delete_genre":
        sql = "DELETE FROM GENRE_OF WHERE mid = " + str(mid) + " AND gen = " + str(gen) + ";"
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            res.set_data(e.pgerror)
            conn.rollback()
            return res
    if aid!="null" and (mode == "add_actor" or mode == "register"):
        sql = "INSERT INTO ACTOR_OF(mid,aid) VALUES(" + str(mid) + ", " + str(aid) + ")"; 
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            conn.rollback()
    if aid!="null" and mode == "delete_actor":
        sql = "DELETE FROM ACTOR_OF WHERE mid = " + str(mid) + " AND aid = " + str(aid) + ";"
        try:
            cur.execute(sql) 
        except psycopg2.Error as e:
            res.set_data(e.pgerror)
            conn.rollback()
            return res

    sql = "SELECT Movie.*, region, director_name, DIRECTOR.profile_image AS Director_image FROM MOVIE" \
    + " LEFT OUTER JOIN VERSION ON Movie_id = VERSION.mid" \
            +  " LEFT OUTER JOIN DIRECTOR_OF ON DIRECTOR_OF.mid = Movie_id" \
            + " LEFT OUTER JOIN DIRECTOR ON DIRECTOR_OF.did = Director_id" \
            + " WHERE Movie_id = " + str(mid) + ";" 

    try:
        cur.execute(sql)
        movie = json.dumps(cur.fetchone(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8') 
        res.set_data(movie)
        conn.commit()
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        conn.rollback()
        return res 
    return res 


@app.route('/account/rating/movie', methods=['POST'])
@cross_origin()
def movieRatingLog():
    res = flask.Response()
    uid = request.form['uid']
    mid = request.form['mid']
    
    sql = "SELECT DISTINCT original_title, DATE_PART('year', Start_year), Movie_id, Single_rating, post_image" \
    + " FROM RATING, MOVIE, ACCOUNT" \
    + " WHERE uid = " + str(uid) + " AND mid = Movie_id AND mid = " + str(mid) + ";"

    try:
        cur.execute(sql)
        data =  json.dumps(cur.fetchone(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.set_data(data)
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        conn.rollback()
        return res 
    return res 

@app.route('/rating/log', methods=['POST'])
@cross_origin()
def ratingLog():
    res = flask.Response()
    email = request.form['email_add']
    
    sql = "SELECT original_title, DATE_PART('year', Start_year), Movie_id, Single_rating, post_image, email_add, rating_id" \
    + " FROM RATING, MOVIE, ACCOUNT" \
    + " WHERE Email_add LIKE '%" + email + "%' AND uid = Account_id AND mid = Movie_id ORDER BY rating_id DESC;"

    try:
        cur.execute(sql)
        data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.set_data(data)
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        return res 
    return res 


@app.route('/rating', methods=['POST'])
@cross_origin()
def rating():
    res = flask.Response()
    mid = request.form['movie_id']
    uid = request.form['account_id']
    rating = request.form['rating']

    sql = "INSERT INTO RATING (Single_rating, mid, uid) " \
    + "VALUES (" + rating + ", " + mid + ", " + uid + ");"

    try:
        cur.execute(sql)
        conn.commit()
    except psycopg2.Error as e:
        conn.rollback()
        sql = "UPDATE RATING SET Single_rating = " + rating  + " WHERE mid = " + mid + " AND uid = " + uid + ";"
        try:
            cur.execute(sql)
            conn.commit()
        except psycopg2.Error as e:
            conn.rollback()
    res.set_data(str(cur.rowcount))
    return res 
    

@app.route('/withdraw', methods=['POST'])
@cross_origin()
def withdraw():
    res = flask.Response()
    email = request.form['email_add'] 
    
    sql = "DELETE FROM ACCOUNT WHERE Email_add = '"+email+"';"

    try:
        cur.execute(sql)
        conn.commit()
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        return res 
    res.set_data(str(cur.rowcount))
    return res

@app.route('/account', methods=['POST'])
@cross_origin()
def update():
    res = flask.Response() 
    email = request.form['email_add'] 
    column = request.form['column']
    value = request.form['value']

    if column == 'sid':
        sql = "UPDATE ACCOUNT SET "+column+" = "+value+" WHERE Email_add = '"+email+"';"
    else: 
        sql = "UPDATE ACCOUNT SET "+column+" = '"+value+"' WHERE Email_add = '"+email+"';"

    try:
        cur.execute(sql)
        conn.commit()
        sql = "SELECT * FROM ACCOUNT WHERE Email_add = '" + email + "';"
        cur.execute(sql)
        data =  json.dumps(cur.fetchone(), indent =2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.set_data(data) 
        return res
    except psycopg2.Error as e:
        conn.rollback()
        res.set_data(e.pgerror)
        return res



@app.route('/signin', methods=['POST'])
@cross_origin()
def signin():
    res = flask.Response()
    email = request.form['email_add'] 
    password = request.form['password']

    sql = "SELECT * FROM ACCOUNT WHERE Email_add = '" + email + "' AND Password = '" + password + "';"
    
    cur.execute(sql) 
    data =  json.dumps(cur.fetchall(), indent =2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
    res.set_data(data) 
    return res

@app.route('/signup', methods=['POST'])
@cross_origin()
def signup():
    res = flask.Response()
    email = request.form['email_add']
    password = request.form['password']
    fname = request.form['first_name']
    lname = request.form['last_name']

    sql = "INSERT INTO ACCOUNT(email_add, password, first_name, last_name, sid)" \
    + "VALUES('"+email+"', '"+password+"', '"+fname+"', '"+lname+"', 1);"
    try:
        cur.execute(sql)
        conn.commit()
    except psycopg2.Error as e:
        res.set_data(e.pgerror)
        return res
    sql = "SELECT * FROM ACCOUNT WHERE Email_add = '" + email + "' AND Password = '" + password + "';"
    cur.execute(sql)
    data =  json.dumps(cur.fetchall(), indent =2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
    res.set_data(data) 
    return res
    
 
@app.route('/movie')
def info():
    res = flask.Response()

    title = request.args.get('title') 
    uid = request.args.get('uid')
    isAdmin = request.args.get('is_admin')
    sql = "SELECT DISTINCT Original_title, DATE_PART('year', Start_year) AS Year, Movie_id, Post_image, rating, director_name," \
    + " Running_time, Start_year, End_year, Type, Is_adult" \
    + " FROM MOVIE LEFT OUTER JOIN GENRE_OF ON GENRE_OF.mid = Movie_id LEFT OUTER JOIN GENRE ON gen = Genre_id" \
    + " LEFT OUTER JOIN ACTOR_OF ON ACTOR_OF.mid = Movie_id LEFT OUTER JOIN ACTOR ON aid = Actor_id" \
    + " LEFT OUTER JOIN VERSION ON VERSION.mid = Movie_id LEFT OUTER JOIN DIRECTOR_OF ON DIRECTOR_OF.mid = Movie_id LEFT OUTER JOIN DIRECTOR ON DIRECTOR_OF.did = Director_id WHERE"
    if title == "any":
        sql = sql + " LOWER(Original_title) LIKE '%%'" 
    else: 
        sql = sql + " LOWER(Original_title) LIKE '%" + title + "%'" 

    if isAdmin == None:
        sql = sql + " AND NOT EXISTS (SELECT * FROM RATING WHERE uid = " + str(uid) + " AND Movie_id = RATING.mid)"


    genre = request.args.get('genre')
    if genre!=None:
        sql = sql + " AND LOWER(Genre) LIKE '%" + genre + "%'"

    type = request.args.get('type')
    if type!=None:
        sql = sql + " AND LOWER(type) LIKE '%" + type + "%'" 
        
    region = request.args.get('region')
    if region!=None:
        sql = sql + " AND LOWER(region) LIKE '%" + region + "%'" 

    runTime = request.args.get('running_time')
    if runTime!=None:
        sql = sql + " AND LOWER(Running_time) LIKE '%" + runTime + "%'" 

    minStartYear = request.args.get('minStartYear')
    maxStartYear = request.args.get('maxStartYear')
    if minStartYear!=None:
        sql = sql + " AND DATE_PART('year',Start_year) >= '" + minStartYear + "'";
        sql = sql + " AND DATE_PART('year',Start_year) <= '" + maxStartYear + "'";

    minEndYear = request.args.get('minEndYear')
    maxEndYear = request.args.get('maxEndYear')
    if minEndYear!=None:
        sql = sql + " AND DATE_PART('year',End_year) >= '" + minEndYear + "'";
        sql = sql + " AND DATE_PART('year',End_year) <= '" + maxEndYear + "'";

    actor = request.args.get('actor')
    if actor!=None:
        sql = sql + " AND LOWER(Actor_name) LIKE '%" + actor + "%'"

    director = request.args.get('director')
    if director!=None:
        sql = sql + " AND LOWER(director_name) LIKE '%" + director + "%'"

    minRating = request.args.get('minRating')
    maxRating = request.args.get('maxRating')
    if minRating!=None:
        sql = sql + " AND Rating >= " + minRating + " AND Rating <= " + maxRating

    sql = sql + ';'
    
    try:
        cur.execute(sql); 
        data =  json.dumps(cur.fetchall(), indent = 2, use_decimal=True, sort_keys=True, default=str).encode('utf8')
        res.headers.add("Access-Control-Allow-Origin","*")
        res.set_data(data) 
        return res
    except psycopg2.Error as e:
        conn.rollback()
        res.set_data(e)
        return None


if __name__ == "__main__":
    ssl_context = ssl.SSLCONTEXT(ssl.PROTOCOL_TLS)
    ssl_context.load_cert_chain(certfile='certificate.crt',keyfile='private.key',password='1234')
    app.run(host='0.0.0.0', port = 443, ssl_context=ssl_context)

