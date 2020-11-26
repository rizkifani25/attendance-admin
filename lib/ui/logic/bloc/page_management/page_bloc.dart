import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is RenderSelectedPage) {
      yield* _mapRenderSelectedPageToState(event);
    }
  }

  Stream<PageState> _mapRenderSelectedPageToState(RenderSelectedPage event) async* {
    yield PageLoading();
    if (event.pageState == 0) {
      yield PageRoomView();
    } else if (event.pageState == 1) {
      yield PageLecturerView();
    } else if (event.pageState == 2) {
      yield PageStudentView();
    }
  }
}
