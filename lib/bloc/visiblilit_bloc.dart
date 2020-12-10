import 'package:rxdart/rxdart.dart';

class VisibilityBloc {
  final _visibility = PublishSubject<bool>();

  Observable<bool> get visiblity => _visibility.stream;

  makeVisible() {
    _visibility.sink.add(true);
  }

  makeInvisible(movieId) async {
    _visibility.sink.add(false);
  }

  dispose() {
    _visibility.close();
  }
}
