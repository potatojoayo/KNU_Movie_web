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
Os | Window & Mac (Linux for DB) | 10, catalina
DBMS | PostgreSQL | 12.4  
Server | AWS EC2(Flask) | -  
IDE | VSCode | 1.47
Language| Dart (Flutter) | sdk >=2.7.0 <3.0.0

---

## How to Use



web: https://potatojoayo.github.io/web

Click Web! <br/>
But before,<br/>
Because of certification issue,<br/>
## https://3.35.27.29:3000/<br/>
## should be visit just for the first time and 'allow unsafe connection' <br/>
It would be fixed soon



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
  The server is alway on by aws ec2 via flask, a python web frame work.<br/>
  <br/>
  Transaction controll was not considered since there will be minor problems which are hardly noticable.<br/>
  There are only two function that user can write on DB, register and rating.<br/>
  Either of these functions doesn't affect any other user using DB; any duplication is restricted at DB level.<br/>
  Any other functions is select instruction that no problem concerning transaction there will be.<br/>
  
 

# knu_movie_web

A new Flutter project.
