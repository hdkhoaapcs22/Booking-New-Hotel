class ShowAuthError {
  String _messageFirstFieldError = "",
      _messageSecondFieldError = "",
      _messageThirdFieldError = "";
  double _gapBetweenFirstAndSecondFieldDuringError = 34,
      _gapBetweenThirdFieldAndButtonDuringError = 34,
      _gapBetweenSecondAndThirdFieldDuringError = 34;

  void setMessageFirstFieldError({required String messageFirstFieldError}) {
    _messageFirstFieldError = messageFirstFieldError;
  }

  void setMessageSecondFieldError({required String messageSecondFieldError}) {
    _messageSecondFieldError = messageSecondFieldError;
  }

  void setMessageThirdFieldError({required String messageThirdFieldError}) {
    _messageThirdFieldError = messageThirdFieldError;
  }

  void setGapBetweenFirstAndSecondFieldDuringError(
      {required double gapBetweenFirstAndSecondFieldDuringError}) {
    _gapBetweenFirstAndSecondFieldDuringError =
        gapBetweenFirstAndSecondFieldDuringError;
  }

  void setGapBetweenThirdFieldAndButtonDuringError(
      {required double gapBetweenThirdFieldAndButtonDuringError}) {
    _gapBetweenThirdFieldAndButtonDuringError =
        gapBetweenThirdFieldAndButtonDuringError;
  }

  void setGapBetweenSecondAndThirdDuringError(
      {required double gapBetweenSecondAndThirdFieldDuringError}) {
    _gapBetweenSecondAndThirdFieldDuringError =
        gapBetweenSecondAndThirdFieldDuringError;
  }

  String get getmessageFirstFieldError => _messageFirstFieldError;
  String get getmessageSecondFieldError => _messageSecondFieldError;
  String get getmessageThirdFieldError => _messageThirdFieldError;
  double get getgapBetweenFirstAndSecondFieldDuringError =>
      _gapBetweenFirstAndSecondFieldDuringError;
  double get getgapBetweenThirdFieldAndButtonDuringError =>
      _gapBetweenThirdFieldAndButtonDuringError;
  double get getgapBetweenSecondAndThirdFieldDuringError =>
      _gapBetweenSecondAndThirdFieldDuringError;
}
