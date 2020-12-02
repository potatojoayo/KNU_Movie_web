import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class SelectBloc {
  final _api = API();
  final _fetcherHR = PublishSubject<List<Movie>>();
  final _fetcherKR = PublishSubject<List<Movie>>();
  final _fetcherCS = PublishSubject<List<Movie>>();

  Observable<List<Movie>> get highRatingList => _fetcherHR.stream;
  Observable<List<Movie>> get hotKoreaList => _fetcherKR.stream;
  Observable<List<Movie>> get classicList => _fetcherCS.stream;

  fetchHRList(String uid) async {
    List<Movie> fetchedHRList = await _api.selectMovie(
      User.uid,
    );
    _fetcherHR.sink.add(fetchedHRList);
  }

  fetchKRList(String uid) async {
    List<Movie> fetchedKRList = await _api.selectMovie(
      User.uid,
    );
    _fetcherKR.sink.add(fetchedKRList);
  }

  fetchCSList(String uid) async {
    List<Movie> fetchedCSList = await _api.selectMovie(
      User.uid,
    );
    _fetcherCS.sink.add(fetchedCSList);
  }

  dispose() {
    _fetcherHR.close();
    _fetcherKR.close();
    _fetcherCS.close();
  }
}
