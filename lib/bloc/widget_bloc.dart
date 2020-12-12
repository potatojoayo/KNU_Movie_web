import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class WidgetBloc {
  final _widget = PublishSubject<Widget>();

  Stream<Widget> get widget => _widget.stream;

  setWidget(Widget widget) {
    _widget.sink.add(widget);
  }

  dispose() {
    _widget.close();
  }
}
