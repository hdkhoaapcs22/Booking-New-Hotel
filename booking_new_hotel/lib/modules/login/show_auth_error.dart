class ShowAuthError {
  String _messageEmailError = "", _messagePasswordError = "", _messagePasswordConfirmError = "";
  double _gapBetweenEmailAndPasswordDuringError = 34,
      _gapBetweenPasswordAndButtonDuringError = 34,
      _gapBetweenPasswordAndConfirmPasswordDuringError = 34;

  void setMessageEmailError({required String messageEmailError}) {
    _messageEmailError = messageEmailError;
  }

  void setMessagePasswordError({required String messagePasswordError}) {
    _messagePasswordError = messagePasswordError;
  }

  void setMessagePasswordConfirmError({required String messagePasswordConfirmError}) {
    _messagePasswordConfirmError = messagePasswordConfirmError;
  }

  void setGapBetweenEmailAndPasswordDuringError(
      {required double gapBetweenEmailAndPasswordDuringError}) {
    _gapBetweenEmailAndPasswordDuringError =
        gapBetweenEmailAndPasswordDuringError;
  }

  void setGapBetweenPasswordAndButtonDuringError(
      {required double gapBetweenPasswordAndButtonDuringError}) {
    _gapBetweenPasswordAndButtonDuringError =
        gapBetweenPasswordAndButtonDuringError;
  }

  void setGapBetweenPasswordAndConfirmPasswordDuringError(
      {required double gapBetweenPasswordAndConfirmPasswordDuringError}) {
    _gapBetweenPasswordAndConfirmPasswordDuringError =
        gapBetweenPasswordAndConfirmPasswordDuringError;
  }

  void clear()
  {
    _messageEmailError = "";
    _messagePasswordError = "";
    _messagePasswordConfirmError = "";
    _gapBetweenEmailAndPasswordDuringError = 34;
    _gapBetweenPasswordAndButtonDuringError = 34;
    _gapBetweenPasswordAndConfirmPasswordDuringError = 34;
  }

  String get getMessageEmailError => _messageEmailError;
  String get getMessagePasswordError => _messagePasswordError;
  String get getMessagePasswordConfirmError => _messagePasswordConfirmError;
  double get getGapBetweenEmailAndPasswordDuringError =>
      _gapBetweenEmailAndPasswordDuringError;
  double get getGapBetweenPasswordAndButtonDuringError =>
      _gapBetweenPasswordAndButtonDuringError;
  double get getGapBetweenPasswordAndConfirmPasswordDuringError =>
      _gapBetweenPasswordAndConfirmPasswordDuringError;
}
