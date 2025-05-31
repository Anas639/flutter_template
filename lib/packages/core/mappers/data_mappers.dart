/// A Data Mapper that maps [DTO] to [DOMIN] and vice versa
/// ```dart
/// class UserMapper implements DataMapper<User, UserDto> {
///   @override
///   UserDto toData(User domain) {
///     return UserDto(
///       id: domain.id,
///       name: domain.name,
///       email: domain.email,
///       profilePicture: domain.profilePicture,
///       token: domain.token,
///     );
///   }
///
///   @override
///   User toDomain(UserDto data) {
///     return User(
///       token: data.token,
///       profilePicture: data.profilePicture,
///       email: data.email,
///       name: data.name,
///       id: data.id,
///     );
///   }
/// }
///
///
/// class UserRepository {
///   const UserRepository({required this.mapper});
///   final DataMapper<User, UserDto> mapper;
/// }
///
/// void main(){
///   final repo = UserRepository(mapper: UserMapper());
/// }
/// ```
abstract interface class DataMapper<DOMAIN, DATA> {
  DOMAIN toDomain(DATA data);
  DATA toData(DOMAIN domain);
}
