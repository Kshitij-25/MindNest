enum LoadStatus { initial, loading, success, failure }

extension LoadStatusX on LoadStatus {
  bool get isLoading =>
      this == LoadStatus.loading || this == LoadStatus.initial;
  bool get isFailure => this == LoadStatus.failure;
}
