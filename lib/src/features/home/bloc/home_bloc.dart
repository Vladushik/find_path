import 'package:equatable/equatable.dart';
import 'package:find_path/src/core/utils/validator.dart';
import 'package:find_path/src/features/home/data/models/models.dart';
import 'package:find_path/src/features/home/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:find_path/src/core/form_status_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required HomeRepository repository,
  })  : _repository = repository,
        super(const HomeState()) {
    on<HomeUrlChangedEvent>(_onUrlChanged);
    on<HomeStartSubmittedEvent>(_onStartSubmit);
    on<HomePostSubmittedEvent>(_onPostSubmit);
  }

  final HomeRepository _repository;

  void _onUrlChanged(
    HomeUrlChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    final url = event.url;
    emit(state.copyWith(url: url));
  }

  Future<void> _onStartSubmit(
    HomeStartSubmittedEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(startStatus: FormStatus.loading));
      final data = await _repository.getData(state.url);
      final listOfListsOfPoints = await _repository.calculatePath(data);
      final pathRequestModels = await _repository.createPostObject(data);
      emit(
        state.copyWith(
          dataModel: data,
          shortWayPoints: listOfListsOfPoints,
          pathRequestModels: pathRequestModels,
          startStatus: FormStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          startStatus: FormStatus.failure,
          errorSubmit: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> _onPostSubmit(
    HomePostSubmittedEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(postStatus: FormStatus.loading));
      await _repository.postPath(state.pathRequestModels);
      emit(state.copyWith(postStatus: FormStatus.success));
      emit(state.copyWith(postStatus: FormStatus.initial));
    } catch (e) {
      emit(state.copyWith(postStatus: FormStatus.failure));
      rethrow;
    }
  }
}
