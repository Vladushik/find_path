part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

final class HomeUrlChangedEvent extends HomeEvent {
  const HomeUrlChangedEvent(this.url);

  final String url;

  @override
  List<Object> get props => [url];
}

final class HomeStartSubmittedEvent extends HomeEvent {
  const HomeStartSubmittedEvent();
}

final class HomePostSubmittedEvent extends HomeEvent {
  const HomePostSubmittedEvent();
}
