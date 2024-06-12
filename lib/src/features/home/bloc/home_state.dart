part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.startStatus = FormStatus.initial,
    this.postStatus = FormStatus.initial,
    this.url = '',
    this.errorSubmit = '',
    this.dataModel,
    this.shortWayPoints = const [],
    this.pathRequestModels = const [],
  });

  final PathDataModel? dataModel;
  final List<List<Point>> shortWayPoints;
  final FormStatus startStatus;
  final FormStatus postStatus;
  final String url;
  final String errorSubmit;
  final List<PathRequestModel> pathRequestModels;

  bool get isValid => Validator.isUrlValid(url);

  HomeState copyWith({
    PathDataModel? dataModel,
    List<List<Point>>? shortWayPoints,
    FormStatus? startStatus,
    FormStatus? postStatus,
    String? url,
    String? errorSubmit,
    List<PathRequestModel>? pathRequestModels,
  }) {
    return HomeState(
      dataModel: dataModel ?? this.dataModel,
      shortWayPoints: shortWayPoints ?? this.shortWayPoints,
      startStatus: startStatus ?? this.startStatus,
      postStatus: postStatus ?? this.postStatus,
      url: url ?? this.url,
      errorSubmit: errorSubmit ?? this.errorSubmit,
      pathRequestModels: pathRequestModels ?? this.pathRequestModels,
    );
  }

  @override
  List<Object?> get props => [
        startStatus,
        url,
        errorSubmit,
        dataModel,
        shortWayPoints,
        postStatus,
        pathRequestModels,
      ];
}
