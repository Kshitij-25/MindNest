/// Generic async UI status used by cubit states across features.
enum ViewStatus { initial, loading, loaded, error }

extension ViewStatusX on ViewStatus {
  bool get isLoading =>
      this == ViewStatus.loading || this == ViewStatus.initial;
  bool get isLoaded => this == ViewStatus.loaded;
  bool get isError => this == ViewStatus.error;
}
