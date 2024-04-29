class ShowAuthError {
  late String _message;
  int? _gapBetweenEmailAndPasswordDuringError,
      _gapBetweenPasswordAndButtonDuringError,
      _gapBetweenPasswordAndConfirmPasswordDuringError;

  ShowAuthError({
    required int gapBetweenEmailAndPasswordDuringError,
    required int gapBetweenPasswordAndButtonDuringError,
    required int gapBetweenPasswordAndConfirmPasswordDuringError,
  }) {
    _gapBetweenEmailAndPasswordDuringError =
        gapBetweenEmailAndPasswordDuringError;
    _gapBetweenPasswordAndButtonDuringError =
        gapBetweenPasswordAndButtonDuringError;
    _gapBetweenPasswordAndConfirmPasswordDuringError =
        gapBetweenPasswordAndConfirmPasswordDuringError;
  }

  void setMessage({required String message}) {
    _message = message;
  }

  void setGapBetweenEmailAndPasswordDuringError(
      {required int gapBetweenEmailAndPasswordDuringError}) {
    _gapBetweenEmailAndPasswordDuringError =
        gapBetweenEmailAndPasswordDuringError;
  }

  void setGapBetweenPasswordAndButtonDuringError(
      {required int gapBetweenPasswordAndButtonDuringError}) {
    _gapBetweenPasswordAndButtonDuringError =
        gapBetweenPasswordAndButtonDuringError;
  }

  void setGapBetweenPasswordAndConfirmPasswordDuringError(
      {required int gapBetweenPasswordAndConfirmPasswordDuringError}) {
    _gapBetweenPasswordAndConfirmPasswordDuringError =
        gapBetweenPasswordAndConfirmPasswordDuringError;
  }

  String get getMessage => _message;
  int get getGapBetweenEmailAndPasswordDuringError =>
      _gapBetweenEmailAndPasswordDuringError!;
  int get getGapBetweenPasswordAndButtonDuringError =>
      _gapBetweenPasswordAndButtonDuringError!;
  int get getGapBetweenPasswordAndConfirmPasswordDuringError =>
      _gapBetweenPasswordAndConfirmPasswordDuringError!;
}
