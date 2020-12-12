import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _api = API();
  final _fetcherHR = PublishSubject<List<Movie>>();
  final _fetcherKR = PublishSubject<List<Movie>>();
  final _fetcherCS = PublishSubject<List<Movie>>();
  final _fetcherSL = PublishSubject<List<Movie>>();

  Stream<List<Movie>> get highRatingList => _fetcherHR.stream;
  Stream<List<Movie>> get hotKoreaList => _fetcherKR.stream;
  Stream<List<Movie>> get classicList => _fetcherCS.stream;
  Stream<List<Movie>> get searchList => _fetcherSL.stream;

  fetchSearchList(int uid, List<ConditionValue> conditionValue) async {
    List<Movie> fetchedSearchList =
        await _api.selectMovie(uid, conditionValue: conditionValue);
    _fetcherSL.sink.add(fetchedSearchList);
  }

  fetchHRList(int uid) async {
    List<Movie> fetchedHRList = await _api.selectMovie(
      uid,
    );
    _fetcherHR.sink.add(fetchedHRList);
  }

  fetchKRList(int uid) async {
    List<Movie> fetchedKRList = await _api.selectMovie(
      uid,
    );
    _fetcherKR.sink.add(fetchedKRList);
  }

  fetchCSList(int uid) async {
    List<Movie> fetchedCSList = await _api.selectMovie(
      uid,
    );
    _fetcherCS.sink.add(fetchedCSList);
  }

  dispose() {
    _fetcherHR.close();
    _fetcherKR.close();
    _fetcherCS.close();
    _fetcherSL.close();
  }
}
