# TODOVER ✔️

👷🏗️ An over engineered To-Do app for the sake of a clean flutter template.

## 🚀 Getting Started

### 🌐 Starting the server

This project comes with a simple *REST API* to login and manage your Todos.
It's packed inside the  `server` project.

Of course the server won't start by itself so here's how to do it 😎:

- If you're on a Unix like system just run:

```bash
cd server
./run_server.sh
```

- you're on *Windows*  just open the project in your vscode and run

```bash
dart run --define=PORT=4000
```

> 💡You can use whatever port you want just make sure you configure the app
> to use the same port. We'll see more about it later.

### ⚙️ App Configuration

The app has a `.env.dev` file that contains some configuration parameters.

```env
BASE_URL=http://192.168.11.102:4000/
MIN_PASSWORD_LENGTH=6
```

The server can receive requests from the LAN.
So by using your local computer's IP as the base URL,
Your phone (or any device) can smoothly connect to the API if it's on the same LAN.

Don't forget to use the same *PORT* number from the early step.
By default it will be port *4000*.

### 📱 Running the App

Just run the main project and enjoy your over engineered TODO app.

## Project Architecture

We follow a **Clean architecture + MVVM** pattern with clean separation of concerns.

``` bash
lib
├── di.dart
├── features
│   ├── auth
│   │   ├── data
│   │   │   ├── api
│   │   │   │   ├── response
│   │   │   │   │   ├── auth_response.dart
│   │   │   │   │   └── auth_response.g.dart
│   │   │   │   └── services
│   │   │   │       ├── auth_service.dart
│   │   │   │       └── auth_service.g.dart
│   │   │   ├── dto
│   │   │   │   ├── login_dto.dart
│   │   │   │   ├── login_dto.g.dart
│   │   │   │   ├── user_dto.dart
│   │   │   │   └── user_dto.g.dart
│   │   │   ├── mappers
│   │   │   │   └── user_mapper.dart
│   │   │   └── repository
│   │   │       └── auth_repository_impl.dart
│   │   ├── di.dart
│   │   ├── domain
│   │   │   ├── constraints.dart
│   │   │   ├── entities
│   │   │   │   ├── user.dart
│   │   │   │   └── user.g.dart
│   │   │   ├── repositories
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases
│   │   │       └── login_usecase.dart
│   │   └── presentation
│   │       ├── routes
│   │       │   └── routes.dart
│   │       ├── screens
│   │       │   └── login_screen.dart
│   │       └── views
│   │           └── login_view.dart
│   ├── settings
│   │   ├── di.dart
│   │   └── presentatin
│   │       ├── routes
│   │       │   └── routes.dart
│   │       ├── screens
│   │       │   └── settings_screen.dart
│   │       ├── store
│   │       │   └── settings_store.dart
│   │       └── widgets
│   │           ├── dark_mode_switch.dart
│   │           └── settings_icon.dart
│   ├── todo
│   │   ├── data
│   │   │   ├── api
│   │   │   │   ├── response
│   │   │   │   │   ├── todo_response.dart
│   │   │   │   │   ├── todo_response.g.dart
│   │   │   │   │   ├── todos_response.dart
│   │   │   │   │   └── todos_response.g.dart
│   │   │   │   └── services
│   │   │   │       ├── todo_service.dart
│   │   │   │       └── todo_service.g.dart
│   │   │   ├── data_source
│   │   │   │   ├── todo_local_ds.dart
│   │   │   │   └── todo_remote_ds.dart
│   │   │   ├── dto
│   │   │   │   ├── new_todo.dart
│   │   │   │   ├── new_todo.g.dart
│   │   │   │   ├── todo_dto.dart
│   │   │   │   ├── todo_dto.g.dart
│   │   │   │   ├── update_todo.dart
│   │   │   │   └── update_todo.g.dart
│   │   │   ├── mappers
│   │   │   │   └── todo_mapper.dart
│   │   │   └── repository
│   │   │       └── todo_repository_impl.dart
│   │   ├── di.dart
│   │   ├── domain
│   │   │   ├── entities
│   │   │   │   ├── todo.dart
│   │   │   │   └── todo.g.dart
│   │   │   ├── repositories
│   │   │   │   └── todo_repository.dart
│   │   │   └── values
│   │   │       └── todo_progress.dart
│   │   └── presentation
│   │       ├── routes
│   │       │   └── routes.dart
│   │       ├── screens
│   │       │   ├── todo_details_screen.dart
│   │       │   └── todos_screen.dart
│   │       ├── store
│   │       │   └── todos_store.dart
│   │       ├── views
│   │       │   ├── add
│   │       │   │   ├── add_todo_view.dart
│   │       │   │   └── add_todo_viewmodel.dart
│   │       │   ├── delete
│   │       │   │   ├── todo_delete_view.dart
│   │       │   │   └── todo_delete_viewmodel.dart
│   │       │   ├── details
│   │       │   │   ├── todo_details_view.dart
│   │       │   │   └── todo_details_viewmodel.dart
│   │       │   ├── progress
│   │       │   │   ├── todo_progress_view.dart
│   │       │   │   └── todo_progress_viewmodel.dart
│   │       │   ├── todos_view.dart
│   │       │   └── todos_viewmodel.dart
│   │       └── widgets
│   │           ├── todo_list_item.dart
│   │           └── todo_list_item_skeleton.dart
│   └── user
│       └── presentation
│           └── widgets
│               ├── user_appbar_widget.dart
│               └── user_avatar.dart
├── main.dart
├── main_shell.dart
├── packages
│   └── core
│       ├── core.dart
│       ├── di
│       │   ├── di.dart
│       │   └── service_locator.dart
│       ├── domain
│       │   └── use_case.dart
│       ├── error
│       │   └── failure.dart
│       ├── logs
│       │   └── logger.dart
│       ├── mappers
│       │   └── data_mappers.dart
│       ├── network
│       │   ├── base_api_response.dart
│       │   ├── base_api_response.g.dart
│       │   ├── dio_factory.dart
│       │   └── interceptors
│       │       └── auth_interceptor.dart
│       ├── session
│       │   ├── secure_user_session.dart
│       │   ├── session_data.dart
│       │   ├── session_data.g.dart
│       │   └── user_session.dart
│       ├── storage
│       │   ├── key_value_storage.dart
│       │   └── secure_storage.dart
│       ├── types
│       │   └── types.dart
│       ├── ui
│       │   ├── dialogs
│       │   │   └── confirmation_dialog.dart
│       │   ├── forms
│       │   │   └── form_validators.dart
│       │   ├── theme
│       │   │   ├── extensions
│       │   │   │   └── text_theme_extension.dart
│       │   │   └── theme.dart
│       │   ├── toasts.dart
│       │   └── widgets
│       │       ├── logout_icon.dart
│       │       └── shimmer_widget.dart
│       └── utils
│           └── string_utils.dart
├── router.dart
└── settings_shell.dart

```

## 📦 Core

The core package contains code that can be shared between features.

### 💉 Dependency Injection

The *core* package provides a *service locator* `di/service_locator.dart` based on
`get_it`.
Since get it uses the *singleton* pattern, other packages/features can access
the injected dependencies if they use the same *service locator* .

The *core* package has its own dependencies that must be injected by calling
`registerCoreDependencies` inside  `di/di.dart`;

### 💼 Domain Layer

The *core* package provides an interface to manage your *use-cases* with ease.
Other features can create *use-cases* that implement one of the interfaces
at `domain/use_case.dart`

```dart
class MyDumbuseCase implements UseCase2<int, String> {
  @override
  String call(int input) {
    if (input < 100) return "😕";
    return "💯";
  }
}
```

Why is the function called `call` instead of something like `execute`
you might wonder 🤨.

Well since in `dart`:

> The `call()` method allows an instance of any class that defines it to emulate
> a function. This method supports the same functionality as normal functions
> such as parameters and return types.

```dart

void main() {
  // call it explicitly
  final r1 = MyDumbuseCase().call(40);
  // or as callable function
  final uc = MyDumbuseCase();
  final r2 = uc(40);
}
```

### ❌ Errors

The *core* package provides some basic failure classes to help other features
They are located at `error/failure.dart`

There are three types of failures for the moment:

- `Failure` - A generic Failure
- `RemoteFailure` - A Failure related to remote stuff like calling an API
- `CacheFilure` - A Failure related to locally cached data

### 📝 Logs

The *core* package provides an application logger that other features can use
and it's located at `logs/logger.dart`.

```dart
void main(){
  AppLogger.debug("🐛");
  AppLogger.error("❌");
  AppLogger.info("ℹ️");
  AppLogger.warning("⚠️");
}
```

### 🗺️ Mappers

The *core* package provides a `DataMapper` interface to help other features
map *DTOs* to *Domain Entities* and vice versa.

It is located at `mappers/data_mappers.dart`.

```dart
class UserMapper implements DataMapper<User, UserDto> {
  @override
  UserDto toData(User domain) {
    return UserDto(
      id: domain.id,
      name: domain.name,
      email: domain.email,
      profilePicture: domain.profilePicture,
      token: domain.token,
    );
  }

  @override
  User toDomain(UserDto data) {
    return User(
      token: data.token,
      profilePicture: data.profilePicture,
      email: data.email,
      name: data.name,
      id: data.id,
    );
  }
}


class UserRepository {
  const UserRepository({required this.mapper});
  final DataMapper<User, UserDto> mapper;
}

void main(){
  final repo = UserRepository(mapper: UserMapper());
}
```

### 🌐 Network

#### 🏭 Dio factory

The *core* project provides a factory to create *Dio* clients

You can call `createDioClient()` and pass a *base URL*.
The factory will take care of other stuff like adding *interceptors*...

> We might add more parameters to this factory later!

#### 👂 Interceptors

- Auth Interceptor - `authInterceptor`:

Intercepts *Dio* requests and adds Bearer token using *UserSessionService*.
It will ignore Requests with `no_auth` extra set to *true*.

We can set extra options using `retrofit` like this:

```dart
  @POST('')
  @Extra({
    'no_auth': true,
  })
  Future<AuthResponse> login(@Body() LoginDto login);
```

### 👤 Session

The *core* package provides a `UserSessionService` interface that other features
can use. The service is located at `session/user_session.dart`.

The user session will be injected using the `serviceLocator`
so other features can easily access it and fetch session data.

There's an implementation of the session service called `SecureUserSessionService`
that uses a `SecureStorage` to safely persist the `SessionData`.

When a session is created, an instance of `SessionData` gets serialized into
*JSON* and saved securely.

### 💾 Storage

The *core* package provides a *key/value storage* interface
with multiple implementations.

- `SecureStorage` - `storage/secure_storage.dart`
An implementation that uses `FlutterSecureStorage` to securely persist values.

- `UserSecureStorage` - `storage/secure_storage.dart`
An extension to `SecureStorage` that depends on the current `SessionData`
to save keys per user.

Suppose the current session has a userId equal to 1

```dart
void main(){
  final storage = UserSecureStorage();
  storage.set("favorites", '["🍊","🍌","🍎"]');
}
```

The value will be saved under a new key `1favorites`
where `1` is the id and `favorites` is the original key.

A `UserSecureStorage` instance is accessible via the `serviceLocator`;

### 🎨 UI

The *core* package provides some *UI* elements to help other features
accomplish mundane *UI* tasks.

#### 🗨️ Dialogs

- `ConfirmationDialog` - `ui/dialogs/confirmation_dialog.dart`
An alert dialog with confirmation buttons

#### 🧾 Forms

- `FormValidation` - `ui/forms/form_validators`
A utility class that provides material form validators

```dart
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: TextFormField(
      key: const ValueKey("login#email"),
      controller: _emailController,
      validator: FormValidation.multi([
        FormValidation.requried("The Email is required"),
        FormValidation.email("Please use a valid email"),
      ]),
      decoration: const InputDecoration(hintText: "Email"),
    ),
  );
}
```

#### 🎭 Theme

The *core* package provides an `AppTheme` that has a configuration for both
*light* and *dark* theme modes.

> ℹ️  The App theme provides a Catppuccin based theme
> You can't change the theme from outside of this package
> Maybe in the near future we'll have a way to pass custom extensions
> or something.. Who knows ? 🤷.

There's a `TextThemeExtension` at `ui/theme/extensions/text_theme_extension.dart`
It adds some additional properties such as success color and text color.

So if you use `AppTheme` then you can access this extension via

```dart
final textThemeExtension = Theme.of(context).extension<TextThemeExtension>();
```

#### 🍞 Toasts

The *core* package provides a way to easily show toasts

The file `ui/toasts.dart` contains helper methods to show toasts:

- `showSuccessToast`
- `showErrorToast`

#### 🧱 Widgets

The *core* package has some widgets that might be helpful.

- `LogoutIcon` - `ui/widgets/logout_icon.dart`
 An Icon Button that clears the session when pressed
 *i.e.* **Logout**

- `ShimmerWidget` - `ui/widtget/shimmer_widget.dart`
A widget that displays a shimmer effect

### 🧰 Utils

A good package has good utilities. So is the *core* package.

#### 🔤 Strings - `utils/string_utils.dart`

- `getRandomString`
Returns a [length] long random [String]

> ℹ️ More utilities might be added later

## ✨ Features

*Features* are independent packages with a single concern.
All *feature* are placed under the `features` folder

Every *feature* follows a clean layered *architecture*

### 🔑 auth

This feature is responsible for *authentication* and *session* creation

### ⚙️ settings

This feature keeps track of application settings like *theme mode*

### ☑️ todos

This is actually the main feature of the app.
It manages todo listing and update

### 👤 user

This is a small feature that adds some *user* related *widgets*
