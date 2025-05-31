/// Represents a generic application failure
/// ```dart
/// Failure? doSomething(int x){
///   if(x<0) return Failure(message: 'We don\'t do that here 🖐️');
///   return null;
/// }
///
/// void main(){
///   Failure f? doSomething(-4);
///   if(f != null){
///     print(f.message);
///   }else{
///     print("Success ✅");
///   }
/// }
/// ```
class Failure {
  final String message;
  const Failure({required this.message});

  @override
  String toString() => message;
}

/// A Type of failures related to remote network operations
///
/// ```dart
/// RemoteFaliure? saveToCloud(String data) async{
///  final success = await server.save(data);
///  if(!success){
///   return RemoteFaliure(message: 'I\'m sorry, but your request got rejected 😏');
///  }
///
///  return null;
/// }
/// void main() async{
///   RemoteFaliure? rFailure = await saveToCloud("🤓");
///   if(rFailure != null){
///     print(rFailure.message);
///   }else {
///     print("Success ✅");
///   }
/// }
/// ```
class RemoteFaliure extends Failure {
  RemoteFaliure({required super.message});
}

/// A type of failure related to reading/writing to local cache
///
/// ```dart
/// CacheFailure? saveToCache(String data) async {
///   final success = await storage.write(data);
///   if(!success){
///     return CacheFailure(message: 'Your data is still volatile 🐦');
///   }
///
///   return null;
/// }
///
/// void main(){
///   CacheFailure? cFailure = await saveToCache("🔑");
///   if(cFailure != null){
///     print(cFailure.message);
///   }else {
///     print("Success ✅");
///   }
/// }
/// ```
class CacheFailure extends Failure {
  CacheFailure({required super.message});
}
