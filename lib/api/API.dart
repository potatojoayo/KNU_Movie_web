import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/director.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:http/http.dart' as http;

import '../model/account.dart';
import '../model/actor.dart';
import '../model/genre.dart';
import '../model/log.dart';

class API {
  // 기본 세팅
  static const _baseURL = 'http://3.34.197.233:3000/';
  http.Client _client = http.Client();

  /* 영화 겸색 ===================================================================== */
  //
  //
  // 영화 제목으로 db에서 fetch
  Future<List<Movie>> tvSeries(int uid) async {
    final url = _baseURL + 'movie/popular_tv_series';
    final response = await http.post(url, headers: <String, String>{
      'Content_Type': 'application/x-www-form-urlencoded',
    }, body: <String, String>{
      'uid': uid.toString()
    });

    List<Movie> _parseMovie(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return compute(_parseMovie, response.body);
  }

  Future<List<Movie>> classics(int uid) async {
    final url = _baseURL + 'movie/classic';
    final response = await http.post(url, headers: <String, String>{
      'Content_Type': 'application/x-www-form-urlencoded',
    }, body: <String, String>{
      'uid': uid.toString()
    });

    List<Movie> _parseMovie(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return compute(_parseMovie, response.body);
  }

  Future<List<Movie>> hotInKorea(int uid) async {
    final url = _baseURL + 'movie/hot-in-korea';
    final response = await http.post(url, headers: <String, String>{
      'Content_Type': 'application/x-www-form-urlencoded',
    }, body: <String, String>{
      'uid': uid.toString()
    });

    List<Movie> _parseMovie(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return compute(_parseMovie, response.body);
  }

  Future<List<Movie>> highRatings(int uid) async {
    final url = _baseURL + 'movie/highest_rating';
    final response = await http.post(url, headers: <String, String>{
      'Content_Type': 'application/x-www-form-urlencoded',
    }, body: <String, String>{
      'uid': uid.toString()
    });

    List<Movie> _parseMovie(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return compute(_parseMovie, response.body);
  }

  Future<List<Movie>> selectMovie(
    int uid, {
    String title,
    String genre,
    String type,
    String region,
    int runningTime,
    int minRating,
    int maxRating,
    int minStartYear,
    int maxStartYear,
    int minEndYear,
    int maxEndYear,
    String actor,
    String director,
    String isAdmin,
    List<ConditionValue> conditionValue,
  }) async {
    var movieURL = _baseURL + "movie?uid=" + uid.toString();
    if (conditionValue.isNotEmpty) {
      for (ConditionValue c in conditionValue) {
        movieURL += "&" + c.condition + "=" + c.value;
      }
      print(movieURL);
      conditionValue.clear();
    }

    /// uid는 필수로 입력
    if (title == null) {
      movieURL += "&title=any";
    } else {
      movieURL += "&title=" + title;
    }
    if (genre != null) {
      movieURL += "&genre=" + genre;
    }
    if (type != null) {
      movieURL += "&type=" + type;
    }
    if (region != null) {
      movieURL += "&region=" + region;
    }
    if (minRating != null) {
      movieURL += "&minRating=" + minRating.toString();
      movieURL += "&maxRating=" + maxRating.toString();
    }
    if (minStartYear != null) {
      movieURL += "&minStartYear=" + minStartYear.toString();
      movieURL += "&maxStartYear=" + maxStartYear.toString();
    }
    if (runningTime != null) {
      movieURL += "&running_time=" + runningTime.toString();
    }
    if (minEndYear != null) {
      movieURL += "&minEndYear=" + minEndYear.toString();
      movieURL += "&maxEndYear=" + maxEndYear.toString();
    }
    if (actor != null) {
      movieURL += "&actor=" + actor;
    }
    if (director != null) {
      movieURL += "&director=" + director;
    }
    if (isAdmin != null) {
      movieURL += "&is_admin=" + isAdmin;
    }
    final response = await _client.get(movieURL);
    // compute 함수를 사용하여 parsePhotos를 별도 isolate에서 수행합
    // Json 파싱해서 리스트로 저장
    List<Movie> _parseMovie(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return compute(_parseMovie, response.body);
  }

  // 영상물 CRUD
  Future<Movie> crudMovie(
      {String title = "null",
      String gen = "null",
      String type = "null",
      String region = "null",
      String runningTime = "null",
      String startYear = "null",
      String endYear = "null",
      String aid = "null",
      String isAdult = "null",
      String mode = "null",
      String mid = "null",
      String image = "null",
      String did = "null"}) async {
    final updateURL = _baseURL + "movie/update";
    final genreURL = _baseURL + "movie/genre";
    final actorURL = _baseURL + "movie/actor";
    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'original_title': title,
        'type': type,
        'is_adult': isAdult,
        'gen': gen,
        'start_year': startYear,
        'end_year': endYear,
        'aid': aid,
        'mode': mode,
        'mid': mid,
        'running_time': runningTime,
        'region': region,
        'image': image,
        'did': did
      },
    );

    final jsonResponse = json.decode(response.body);

    Movie movie = new Movie.fromJson(jsonResponse);

    // 장르 받아오기

    http.Response resGenre = await http.post(
      genreURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'mid': mid},
    );

    List<Genre> parseGenre(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Genre>((json) => Genre.fromJson(json)).toList();
    }

    Future<List<Genre>> fgenres = compute(parseGenre, resGenre.body);
    var genres = await fgenres;
    // ignore: deprecated_member_use
    movie.genre = List<String>();
    for (Genre g in genres) {
      movie.genre.add(g.genre);
    }

    http.Response resActor = await http.post(
      actorURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'mid': mid},
    );

    List<Actor> parseActor(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Actor>((json) => Actor.fromJson(json)).toList();
    }

    Future<List<Actor>> factors = compute(parseActor, resActor.body);
    var actors = await factors;
    // ignore: deprecated_member_use
    movie.actor = List<String>();
    // ignore: deprecated_member_use
    movie.actorImage = List<String>();
    for (Actor a in actors) {
      movie.actor.add(a.name);
      movie.actorImage.add(a.profileImage);
    }

    print("무비" + movie.originalTitle);
    return movie;
  }

  // 장르 선택

  Future<List<Genre>> selectGenre({String genre}) async {
    final genreURL = _baseURL + "genre/select";
    if (genre == null) genre = "";

    http.Response resGenre = await http.post(
      genreURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'genre': genre},
    );

    List<Genre> parseGenre(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Genre>((json) => Genre.fromJson(json)).toList();
    }

    return compute(parseGenre, resGenre.body);
  }

  // 배우 선택

  Future<List<Actor>> selectActor({String name}) async {
    final genreURL = _baseURL + "actor/select";
    if (name == null) name = "";

    http.Response resGenre = await http.post(
      genreURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'actor': name},
    );

    List<Actor> parseActor(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Actor>((json) => Actor.fromJson(json)).toList();
    }

    return compute(parseActor, resGenre.body);
  }

  // 감독 선택

  Future<List<Director>> selectDirector({String name}) async {
    final genreURL = _baseURL + "director/select";
    if (name == null) name = "";

    http.Response resGenre = await http.post(
      genreURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'director': name},
    );

    List<Director> parseActor(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Director>((json) => Director.fromJson(json)).toList();
    }

    return compute(parseActor, resGenre.body);
  }
/* 회원 관리 ===================================================================== */
//
//

  //회원가입
  Future<Account> signup(
      String email, String password, String fname, String lname) async {
    final loginURL = _baseURL + "signup";
    http.Response response = await http.post(
      loginURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email_add': email,
        'password': password,
        'first_name': fname,
        'last_name': lname
      },
    );
    String code = response.body;
    if (code == '23505')
      return null;
    else {
      final jsonResponse = json.decode(response.body);
      Account account;
      if (response.body.length > 2)
        account = new Account.fromJson(jsonResponse[0]);
      account.isAdmin = await isAdmin(account.uid);
      return account;
    }
  }

  // 로그인
  Future<Account> signin(String email, String password) async {
    final loginURL = _baseURL + "signin";
    final response = await http.post(
      loginURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'email_add': email, 'password': password},
    );
    final jsonResponse = json.decode(response.body);
    Account account;
    if (response.body.length > 2)
      account = new Account.fromJson(jsonResponse[0]);
    else
      return Account(email: 'invaild');
    account.isAdmin = await isAdmin(account.uid);
    return account;
  }

  // 회원 정보 수정
  Future<Account> updateAccount(
      String email, String column, String value) async {
    final updateURL = _baseURL + "account";
    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email_add': email,
        'column': column,
        'value': value
      },
    );
    final jsonResponse = json.decode(response.body);
    Account account = new Account.fromJson(jsonResponse);
    return account;
  }

  //회원탈퇴
  Future<bool> withdraw(String email) async {
    final updateURL = _baseURL + "withdraw";
    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'email_add': email},
    );
    bool success = response.body == '1' ? true : false;
    return success;
  }

  // 평가하기
  Future<bool> rating(String uid, String mid, String rating) async {
    print(uid + mid + rating);
    final updateURL = _baseURL + "rating";
    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'movie_id': mid,
        'account_id': uid,
        'rating': rating
      },
    );
    bool success = response.body == '1' ? true : false;
    return success;
  }

  // 평가 내역 확인
  Future<List<Log>> ratingLog({String email}) async {
    final updateURL = _baseURL + "rating/log";
    String emailAdd;
    if (email != null)
      emailAdd = email;
    else
      emailAdd = "";
    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'email_add': emailAdd,
      },
    );
    // Json 파싱해서 리스트로 저장
    List<Log> _parseLog(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Log>((json) => Log.fromJson(json)).toList();
    }

    return compute(_parseLog, response.body);
  }

  Future<Log> aMovieRating({int uid, int mid}) async {
    final updateURL = _baseURL + "account/rating/movie";

    http.Response response = await http.post(
      updateURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'uid': uid.toString(), 'mid': mid.toString()},
    );
    // Json 파싱해서 리스트로 저장
    if (response.body.length > 10) {
      final parsed = json.decode(response.body);
      final log = Log.fromJson(parsed);
      return log;
    } else {
      final log = Log();
      return log;
    }
  }

  // 어드민 체크
  Future<bool> isAdmin(int uid) async {
    final adminURL = _baseURL + "admin";
    final response = await http.post(
      adminURL,
      headers: <String, String>{
        'Content_Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'uid': uid.toString()},
    );
    bool isAdmin = response.body == "True" ? true : false;
    return isAdmin;
  }
}
