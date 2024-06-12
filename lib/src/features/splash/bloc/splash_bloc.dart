import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:find_path/src/core/form_status_enum.dart';
import 'package:find_path/src/features/splash/data/repositories/splash_repository.dart';

//MARK: - State
final class SplashState extends Equatable {
  const SplashState({
    this.status = FormStatus.loading,
  });

  final FormStatus status;

  SplashState copyWith({
    FormStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

//MARK: - Event
sealed class SplashEvent extends Equatable {
  const SplashEvent();
  @override
  List<Object> get props => [];
}

final class SplashInitEvent extends SplashEvent {
  const SplashInitEvent();

  @override
  List<Object> get props => [];
}

//MARK: - Bloc
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required SplashRepository repository,
  })  : _repository = repository,
        super(const SplashState()) {
    on<SplashInitEvent>(_onInit);
  }

  final SplashRepository _repository;

  Future _onInit(SplashEvent event, Emitter<SplashState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));
      await _repository.getUserFromCache();
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
