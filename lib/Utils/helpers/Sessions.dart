
class SessionControler {
  static final SessionControler _session = SessionControler._internal();

  String? userId;
  String? uid;
  String? image;

  factory SessionControler() {
    return _session;
  }

  SessionControler._internal() {}
}