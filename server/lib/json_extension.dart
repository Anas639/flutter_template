import 'dart:convert';

extension JsonExtension on Object {
  String encodeJSON() {
    return jsonEncode(this);
  }
}
