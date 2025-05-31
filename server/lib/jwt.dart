import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

const _verySecretKey = "0a10573d-0934-4d16-8687-7c6ca0a52c95";

String createUserJWT(String userId) {
  final jwt = JWT(
    {
      'id': userId,
      'issuer': 'localhost',
    },
  );

  return jwt.sign(SecretKey(_verySecretKey));
}

JWT? verifyJWT(String token) {
  try {
    return JWT.verify(token, SecretKey(_verySecretKey));
  } catch (e) {
    print(e.toString());
    return null;
  }
}
