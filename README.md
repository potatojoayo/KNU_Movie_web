# COMP322_phase4

> 2020-2 Database team 12 project phase4
>
> KNU_Movie_Web
>
> Movie Database Web Application

---

## Environment

Environment| Name | Version 
:---: | :---: | :---: 
OS | Window & Mac (Linux for DB) | 10, catalina
DBMS | PostgreSQL | 12.4  
Server | AWS EC2(Flask) | -  
IDE | VSCode | 1.47
Language| Dart (Flutter) | sdk >=2.7.0 <3.0.0

---

## Functions


 ### 1. Recommendation<br/>
 1-1) Without login or any rating history
> 1. Order by average rating desc.
> 2. Movies playedn in Korea order by average rating desc.
> 3. Movies of which start year is before 1980 order by avearge rating desc.
> 4. Tv series order by avg rating desc

 1-2) With more than one rating history
> 1. Movies of thre genres that a user rated most.
> 2. Movies of three actors that a user rated most.
> 3. Movies of three directors that a user rated most.<br/>
> ... plus above four recommendations


 ### 3. Searching movies
 Detail search function provide multiple combinations of conditions including title, genre, actor, type, start/end year, director ... </br>
 By clicking card of a result shows detail features of a movie including those conditions.

 ### 4. Rating and its log
In Account page shows a log of an user's rating history.

 ### 5. Adding and modifying movie in DB (only admin)
 
 ### caution: On press 'Back Button' immediately route the page out of the application.


## How to Use



## web: https://potatojoayo.github.io/web

Click Web! <br/>
But before,<br/>
Because of a certification issue,<br/>
# == IMPORTANT == 
## https://3.35.27.29:3000/<br/>
(api server, https without public authorization)<br/>
should be visit just for the first time and 'allow unsafe connection' <br/>
> It's perfectly safe. (unless, my name is hyobeom Han) <br/>
It would be fixed soon<br/>
And for dependencies, use chrome browser please.<br/>
For some reason, it doesn't work on mobile. It would be fixed too soon.



--admin account<br/>
ID: knu@knu.ac.kr<br/>
pwd: knu

---

## Notice

  DMLs are placed in 'server api' folder as apis.<br/>
  To build, dart and flutter SDK should be installed.<br/>
  It can easily built with VS Code or Android Studio.<br/>
  Along with in OS, flutter and dart plugins should be installed in either ide.<br/>
  <br/>
  The server, aws ec2, is alway on via flask, a python web frame work.<br/>
  <br/>
  Transaction controll was not considered since there will be minor problems which are hardly noticable.<br/>
  There are only two function that user can write on DB, register and rating.<br/>
  Either of these functions doesn't affect any other user using DB; any duplication is restricted at DB level.<br/>
  Any other functions is select instruction that no problem concerning transaction there will be.<br/>
  
  ### line count = 7997
  
 

# knu_movie_web

A new Flutter project.
