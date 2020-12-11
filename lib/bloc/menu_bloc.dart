import 'package:knu_movie_web/model/item.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc {
  final _selectedMenu = PublishSubject<Item>();

  Observable<Item> get selectedMenu => _selectedMenu.stream;

  changeItem(selectedItem) {
    _selectedMenu.sink.add(selectedItem);
  }

  dispose() {
    _selectedMenu.close();
  }
}
