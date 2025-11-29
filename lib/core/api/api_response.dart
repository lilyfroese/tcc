class ApiResponse<T> {
  final T? data;
  final int statusCode;
  final String? error;

  bool get ok => statusCode >= 200 && statusCode < 300;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.error,
  });
}
