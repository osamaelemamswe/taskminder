extension RegExpString on String {
  bool get isValidTitle {
    final titleRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');
    return titleRegExp.hasMatch(this);
  }
}