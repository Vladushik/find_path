enum FormStatus { initial, loading, success, failure }

extension FormStatusX on FormStatus {
  bool get isInitial => this == FormStatus.initial;
  bool get isLoading => this == FormStatus.loading;
  bool get isSuccess => this == FormStatus.success;
  bool get isFailure => this == FormStatus.failure;
}
