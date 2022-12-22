extension StringExtension on String? {
  bool get isBlank => this == null || this!.isEmpty;

  bool get isNotBlank => !isBlank;
}
