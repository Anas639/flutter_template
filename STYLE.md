# Flutter Project Architecture and Coding Guidelines

This document defines the architectural patterns, folder structure, naming
conventions, and best practices for *Flutter* projects using
**clean architecture** and **MVVM**.

## 🎯 Effective Dart

In order to write clean and readable dart code, it is recommended to follow the
[effective dart](https://dart.dev/effective-dart/style) coding style guide.

## ✨ Features

Each features must be within it's own package and should not contain
code
for something else other than the feature itself.
For example a *products* feature should not contain code to place an *order*
because that's a concern of the *orders* feature.

### 🗃️ Layers

 Features must follow the *layered architecture* and contain one or more of
the main layers:

#### 💼 Domain Layer

##### 👤 Entities

Entities are data classes with distinct identities (anything that you can
identify with some id).

E.g., `User`, `Todo`, `Product`,...

Please placed them in `feature/domain/entities`

##### 💎 Value Objects

Value objects are defined by their attributes only, and are not unique.

E.g., `Password`, `Birthday`, `Address`,...

Please placed them in `feature/domain/values`

##### 🗄️ Repositories

Domain repositories are interfaces/abstractions for accessing domain objects.

Please place them in `feature/domain/repositories`

✅ They must contain functions like

- `getAll()`
- `getById(id)`
- `create(data)`
- ...

❌ They should not contain the name of the entity, they are already encapsulated
inside a repository of an entity, adding entity name will be redundant:

- `getAllProducts()`
- `createProductById(id)`
- `deleteProductById(id)`

##### 💼 Usecases

Use cases are encapsulated inside classes that implement one of the `UseCase` interfaces
in the *core* package.

Please place them in `feature/domain/usecases`

❌ Do not create a use case that only forwards a call to a repository.

```dart
class GetSomethingUC implements UseCase2<int, String>{
  @override
  Future<String> call(int input){
    return repository.getSomething(input);
    // as you can see ⬆️ 
    // the call above forwards the input as it is to the repository,
   // which adds one layer of complexity for no good reason 🤷 
  }
}
```

✅ Use cases must be used only if you need to combine some business logic that
requires multiple services into one single call.

```dart
typedef LoginParams = ({
  String email,
  String password,
});

class LoginUC implements UseCase2<LoginParams, Failure?> {
  const LoginUC({
    required this.repository,
    required this.sessionService,
  });

  final AuthRepository repository;
  final UserSessionService sessionService;

  @override
  Future<Failure?> call(LoginParams input) async {
    final response = await repository.login(
      email: input.email,
      password: input.password,
    );

    // when the auth repository returns a failure we return it back
    // if there's a user then we create a session
    return response.fold(
      (l) => l,
      (user) {
        sessionService.createSession(
          SessionData.create(
            token: user.token ?? '',
            userId: user.id.toString(),
            info: user.toJson(),
          ),
        );
        return null;
      },
    );
  }
}
```

> ⚠️ Domain use cases **must not** depend on UI or platform code.

##### ⛓️ Constraints

Domain layers can define a constraints class without actually providing a value

Please put the class in `feature/domain/constraints.dart`

```dart

class FeatureDomainConstraints {
  final int maxLengthOfSomething;

  const FeatureDomainConstraints({
    required this.maxLengthOfSomething,
  });
}
```

You're probably thinking about making constraint attributes static and
accessing them with class name like `FeatureDomainConstraints.maxLengthOfSomething;`.

This will work, but it is better to instantiate it and read values from a
*.env* file, then inject the instance using the *service locator*.

##### 📜 Summary

The Domain Layer

Contains ✅:

- Business entities (pure Dart)
- Value objects
- Abstract repositories
- Use cases

Does not Contain ❌ :

- Flutter specific code
- No access to presentation or platform code

#### 💿 Data Layer

The *data layer* is responsible for accessing data from both *remote* and *local* sources.

##### 🚚 Data Transfer Objects

*Data Transfer Objects* or *DTO*s, are object that carry data between the
application and the *API*.

Please put them in in `feature/data/dto`

The `toJson()` and `fromJson()` should be generated using `json_serializable`
and `build_runner`.

##### 🗺️ Data Mappers

Mappers are used to convert *domain* objects into *DTO*s and vice versa.

Please place them in `feature/data/mappers`

They should implement the `DataMapper` interface from the *core* package

```dart
class ModelMapper implements DataMapper<Model, Dto> {
  @override
  Dto toData(Model domain) {
    return Dto(
      someField: int.parse(domain.someAttribute),
    );
  }

  @override
  Model toDomain(Dto data) {
    return Model(
      someAttribute: data.someField.toString(),
    );
  }
}
```

##### 📦 Data Sources

Data sources can be either *remote* or *local*.

###### 📡 Remote Data Sources

Remote data sources must be placed in `feature/data/remote/`

If the source is an API service then place it in `feature/data/remote/api/services`

To create an API service create a service file in the services directory
containing  abstract class with API calls.

We use `retrofit` to generate API calls and `Dio` as our *http client*.

Let's pretend the base URL is `https://example.com/api/`
and we want to implement calls to a service called `foo`:

> - `GET` `https://example.com/api/foo`
> - `POST` `https://example.com/api/foo`
> - `PUT` `https://example.com/api/foo/{id}`
> - `Delete` `https://example.com/api/foo/{id}`

- We start by defining an abstract class named `FooService`
- We use `@RestApi` annotation with the `baseUrl` attribute set to **"foo"**
- Inside the class we define methods with annotations like `@GET` and `@POST`...
- Leave the path empty `@GET('')` if the API call points to the same service base
URL.
- Generate implementation code with `build_runner`
- The `Dio` instance will be responsible for providing the first part of the
Base URL (`https://..../api/`)

You'll end up with something like this:

```dart

part 'foo_service.g.dart';

@RestApi(baseUrl: 'foo')
abstract class FooService {
  factory FooService(Dio dio, {String? baseUrl}) = _FooService;

  @GET('')
  Future<FooListResponse> listAll();

  @PUT('/{id}')
  Future<FooResponse> update(@Path('id') String id, @Body() UpdateFooDto updateFoo);

  @POST('')
  Future<FooResponse> create(@Body() NewFooDto newFoo);

  @DELETE('/{id}')
  Future<BaseApiResponse> delete(@Path('id') String id);
}
```

##### 💾 Local Data Sources

Local data sources are used to persist data locally into data bases or shared preferences.

All local sources must be places inside `feature/data/local/`

##### 🗄️ Repository implementations

Repositories in the *data* layer implement repos from the *domain* layer.

Repositories can have one or more *data source*.
Preferably injected via the constructor.

Repositories must be placed in `feature/data/repositories/`

Suppose you want to implement `ProductRepository` from the *domain* layer:

```dart

abstract interface class ProductRepository {
  Future<List<Product>> getAll();
}
```

You create a file called `product_repository_impl.dart` in `feature/data/repositories/`
containing a class called `ProductRepositoryImpl` that implements `ProductRepository`

```dart
class ProductRepositoryImpl implements ProductRepository {
}
```

```dart

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProudctLocalDataSource local;


  // use constructor based DI to inject local and remote data sources
  const ProductRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<Product>> getAll() async{
    // you decide if you'll return data from remote or local source
    var mapper = ProductMapper();
    var cache = await local.getAll();
    if(cache != null){
      return cache.map(mapper.toDomain).toList();
    }

    var products = await remote.getAll();
    if(products == null) throw RemoteFailure(message:'');

    return products.map(mapper.toDomain).toList();
  }
}
// ****
```

>💡 A repository can have remote only or local only data sources.
> It depends on your project's use case.

#### 🎨 Presentation Layer

The presentation layer contains **Flutter** code and handle user interactions
with the UI.

We follow the *MVVM* pattern using the `fl_mvvm` package.

##### 🧭 Routes

If a feature wants to provide some *routes* for navigation they must be inside
`feature/presentation/routes.dart` within a class with
static `routes` getter and static methods to navigate:

`feature/presentation/routes.dart`

```dart
final class FeatureRoutes {
  static final routes = [
    GoRoute(
      path: '/some-route',
      builder: (context, state) {
        return const SomeScreen();
      },
    ),
    GoRoute(
      path: '/some-route/:id',
      builder: (context, state) {
        String id = state.pathParameters['id'] ?? '';
        return SomeOtherScreen(
          id: id,
        );
      },
    ),
  ];

  static Future openSomeOtherScreen(BuildContext context, String id) {
    return context.push('/some-route/$id');
  }
}
```

##### 📺 Screens

Screens are widgets that wrap views and other widgets.

They must be placed in `feature/presentation/screens`

Example of a screen:

```dart
class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 24,
          children: [
            AddTodoView(),
            TodoProgressView(),
            Expanded(
              child: TodosView(),
            ),
          ],
        ),
      ),
    );
  }
}
```

##### 🫙 Stores

Stores encapsulate the application state like products lists, user todos list,
selected filter of something, selected theme mode....

Each store must be placed in its own file inside `feature/presentation/store`

We use `signals` to keep the state reactive across the app.
Since we are using the `fl_mvvm` then `signals_flutter` will be available out of
the box.

This is an example of a *Todos store*:

```dart

class TodosStore {
  final _todos = listSignal<Todo>([]);

  List<Todo> get todos => _todos.value.toList();

  void replaceAll(List<Todo> todos) {
    _todos.value = todos;
  }

  void add(Todo todo) {
    _todos.value.add(todo);
  }

  void update({
    required String id,
    required Todo todo,
  }) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index < 0) return;
    _todos[index] = todo;
  }

  void delete(String id) {
    _todos.removeWhere((t) => t.id == id);
  }

  void clear() {
    _todos.clear();
  }
}
```

> ❌ Stores should not contain business logic. They are mere state holders.
>
>⚠️ Domain UseCases should not update stores directly.

##### 👀 Views

A **View** represent the state of a **ViewModel**.
Both views and view models must be placed inside `feature/presentation/views`

The `fl_mvvm` package provides one base View class `FlView`, and one base
ViewModel class `FlViewModel`.

Views extend `FlView` and ViewModels extend `FlViewModel`

You can learn more about this package [here](https://pub.dev/packages/fl_mvvm).

Since our stores use `signals` and `FlViewModel` has a method called
`buildDependencies` that reacts to *signals*. We can take advantage of it to
rebuild the view whenever a store
(or any other signal) value has changed.

For example here we react to `TodoStore` and set Data or empty state accordingly:

```dart
  final _store = serviceLocator.get<TodosStore>();
  @override
  void buildDependencies() {
    final todos = _store.todos;
    if (todos.isEmpty) {
      setEmpty('What\'s on your mind? 🧠');
      return;
    }
    setData(todos);
  }
```

Here we react to `TodoStore` again but this view model converts the todos list
into a `TodoProgress` before setting the data:

```dart
  @override
  void buildDependencies() {
    var todos = serviceLocator.get<TodosStore>().todos;

    int completeCount = todos.where((element) => element.completed).length;
    int inCompleteCount = todos.length - completeCount;

    setData(TodoProgress(completed: completeCount, inCompleted: inCompleteCount));
  }
```

##### 🧰 Widgets

Reusable UI components must be extracted into their own widget class
(`StatefulWidget` or `StatelessWidget`) and be placed in `feature/presentation/widgets`

#### ⚠️ Do & Don't

| ✅ Do | ❌ Don't |
| -------------- | --------------- |
| Keep domain layer pure | Use Flutter in domain layer |
| Update UI state from presentation layer | Update store from domain use case |
| Use stores for UI state | Have business logic in store |
| Separate remote/local data | Mix caching inside the API service itself |

### 💉 Dependency injection

If a feature wants to register some dependencies via the service locator,
it must import the service locator inside the *core* package and expose a
function to register dependencies in `feature/di.dart`.

```dart di.dart

import 'package:flutter_template/packages/core/core.dart';

Future<void> registerDependencies({
  required Dio dio,
}) async {
  // here dio is injected from outside
  serviceLocator.registerSingleton<SomeService>(SomeService(dio));
}
```

---

## 🧭 Router Configuration

We are using `go_router` for the navigation system.

The `lib/router.dart` file contains the global router configuration.

The global configuration can include routes from other features.

```dart

final router = GoRouter(
  routes: [
    ...Feature1.routes,
    ...Feature2.routes,
  ],
);
```

- Use `ShellRoute` for nested navigation if needed.

- It is preferred to extract route shells into a widget
  for example `lib/main_app_shell.dart`.

## 🎨 Theme

- Avoid defining raw colors/styles in widgets as much as possible.
- Theme configuration must provide a `ThemeData` object that can be used in the
`MaterialApp`'s dark theme and light theme.
- Use theme extensions to define custom themes.
- Widgets must access the theme configuration using

```dart
final textTheme = Theme.of(context).textTheme;
final themeExtension = Theme.of(context).extension<CustomThemeExtension>();
```

## 💉 Dependencies

The `lib/di.dart` file contains a method called `injectDependencies`.
This method gets called from the *main* method and it is responsible for injecting other features dependencies.

```dart
void main() async {
  await injectDependencies();
  runApp(const MyApp());
}
```

It is here where you initialize http clients and load env files and do all the initial stuff.

Here's an example of how this method should look like

```dart
Future<void> injectDependencies() async {
  String flavor = Platform.environment['flavor'] ?? 'dev';
  final String dotEnvFile = '.env.$flavor';
  await dotenv.load(fileName: dotEnvFile);
  String baseUrl = dotenv.get('BASE_URL', fallback: '');
  if (baseUrl.isEmpty) {
    throw Exception("BASE_URL not found in .env file");
  }
  final dio = createDioClient(baseUrl: baseUrl);

  await registerCoreDependencies();

  await registerSettingsDependencies(
    storage: serviceLocator.get<UserSecureStorage>(),
  );

  await registerAuthDependencies(
    dio: dio,
    minPasswordLength: int.parse(
      dotenv.get(
        'MIN_PASSWORD_LENGTH',
        fallback: '6',
      ),
    ),
  );
  await registerTodoDependencies(dio: dio);

  // If we gonna support multiple users in a single device then we must reset stores
  // and refresh them in case session changed.
  serviceLocator.get<UserSessionService>().sessionStream.listen((sData) async {
    if (sData == null) {
      serviceLocator.get<TodosStore>().clear();
    } else {
      await serviceLocator.get<SettingsStore>().init();
    }
  });
}
```

## 🧾 Naming Conventions

| Artifact | Prefix | Suffix | Example |
| --------------- | --------------- | --------------- | --------------- |
| Entity | none | none | `User`,`Product` |
| Repository | none | `Repository`, `RepositoryImpl` | `UserRepository`, `UserRepositoryImpl` |
| View | none | `View` | `ProductsView` |
| ViewModel | none | `ViewModel` | `ProductsViewModel` |
| Store | none | `Store` | `ProductsStore` |
| UseCase | A verb like `Get`, `Update`, `Delete` | `UC` | `GetProductsUC`, `UpdateProductUC`, `DeleteProductUC` |
| Service | none | `Service` | `NotificaionService`, `SessionService`, `StorageService`  |

## 🧪 Testing Rules

In case you want to write a *unit test* that depends on another *concrete* class,
use `mockito` or your own mock implementation to Mock *dependencies*
and isolate the *unit*.

| Layer | Test Type |
| -------------- | --------------- |
| Domain | Pure unit test (no mocks of Dio or Flutter) |
| Data | Unit tests with mocks (e.g., mock remote/local) |
| Presentation | Widget + ViewModel tests |
| Core | Integration tests with mocks |

## 🐙 Version Control

### ➕ Staging Files

#### ✅ Do

- Always stage files related to the project
- It is fine to stage auto-generated code

#### ❌ Don't

- Do not stage sensitive information like **API Keys** or some **Credentials**
- Do not stage **.env** files. Only stage changes to **.env.exmaple**
- You should never stage files related to your IDE configuration
- Do not stage build artifacts like **apk** files

### ✔️ Commits

- A single commit must contain related changed. If you have unrelated changes
like adding a new font and fixing some list item, then you'll have to commit
each one separately.

```bash
# ✅ Do  
git add **/theme.dart
git commit -m "feat(ui): change the app font to ..."
git add **/list_item.dart
git commit -m "fix(products): fix text overflow in product list item"
# ❌ Don't
git add .
git commit -m "fix text overflow and add new font"
```

- Commit messages must be meaningful and describe what has been changed.

```bash
# ✅ Do
git commit -m "fix(products): fix text overflow in product list item"
# ❌ Don't
git commit -m "fix ui"
git commit -m "fix stuff 🤨"  
```

- It is preferred to use [semantic commits](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)
Semantic commits are related to Semantic versioning

  - If there's a `fix` we increase the **PATCH** version:
`1.0.0` -> `1.0.1`

  - If there's `feature` we increase the **MINOR** version:
`1.0.1` -> `1.1.0`

  - It there are some `BREAKING CHANGES` we increase the **MAJOR** version:
`1.1.0` -> `2.0.0`

*A semantic commit follow this structure:*

 ```txt
 <type>(<optional scope>): <description>
 [optional body]
 [optional footer(s)]
 ```

*Valid types are:*

 ``` txt
  feat:     A new feature.
  fix:      A bug fix.
  docs:     Documentation changes.
  style:    Code style changes (formatting, missing semicolons, etc.).
  refactor: Code refactoring (neither fixes a bug nor adds a feature).
  test:     Adding or updating tests.
  chore:    Routine tasks like updating dependencies or build tools.
  build:    Changes affecting the build system or external dependencies.
  ci:       Changes to CI configuration files or scripts.
  perf:     Performance improvements.
  revert:   Reverting a previous commit.
```

*Breaking changes*:

If a commit has some breaking changes then it must contain `!` before `:`.

You can also add **`BREAKING CHANGES`** to the footer.

*Examples:*

`feat(auth): add social login via google auth`

`fix(api)!: resolve timeout issue`

`build(gradle): set minSdkVersion to 23`

`docs(changelog): add v2.0.0 changes`

### ⬆️ Pushing Changes

#### ✅ Do

- Make sure your local branch has latest remote changes before pushing new ones

#### ❌ Don't

- Push commits to someone else's branch
- Do not force push commits if you're not the only one using that branch
