// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponesModel {
  bool _isSuccess;
  String _message;
  ResponesModel(
    this._isSuccess,
    this._message,
  );
  bool get isSuccess => _isSuccess;
  String get message => _message;
}
