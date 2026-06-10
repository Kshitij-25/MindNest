# MindNest — Architecture

A role-based mental-wellness app (general users + mental-health professionals) built
with **Feature-First Clean Architecture**, BLoC/Cubit state, GoRouter navigation, and
get_it/injectable dependency injection.

> The data layer is currently backed by **seeded local data sources** (no live backend).
> The networking, serialization, error-handling and DI infrastructure are production-shaped
> so swapping a real API in is a data-source change, not an app-wide refactor.

---

## Layers

```
Presentation  →  Domain  ←  Data
 (Cubits,        (Entities,    (DTO Models [freezed+json],
  Pages,          Repository    Mappers, DataSources,
  Widgets)        interfaces,   Repository impls)
                  UseCases)
```

- **Presentation** depends on **Domain only** (cubits call use cases; pages render entities).
- **Domain** is pure Dart — no Flutter, no Dio, no json. Entities use `Equatable`.
- **Data** implements the domain repositories. DTO **models** (freezed + json_serializable)
  are mapped to **entities** by **mappers**, keeping serialization out of the domain.
- Cross-layer calls return a `Result<T>` (`Ok`/`Err`) carrying a typed `Failure`.

## Folder structure

```
lib/
├── core/                      # cross-cutting infrastructure
│   ├── config/                # Env + AppConfig (per-environment)
│   ├── constants/             # AppConstants
│   ├── di/                    # injection.dart (get_it + injectable) + generated config
│   ├── error/                 # Failure, AppException, Result, error mapper
│   ├── navigation/            # TabScope (shell tab switching)
│   ├── network/               # DioClient + interceptors (auth/retry/logging) + NetworkInfo
│   ├── services/              # SessionService, KeyValueStorage
│   ├── theme/                 # tokens (MnColors ThemeExtension), text scale, ThemeData
│   ├── usecases/              # UseCase contract, NoParams, Unit
│   └── widgets/               # the MindNest design system (MnButton, MnCard, …)
├── features/<feature>/
│   ├── data/{datasource,models,mappers,repositories}
│   ├── domain/{entities,repositories,usecases}
│   ├── presentation/{cubit,pages,widgets}
│   └── di/                    # (DI is annotation-driven; folder reserved)
├── routes/                    # app_router.dart, route_names.dart, route_guards.dart
├── shared/                    # cross-feature models, widgets, helpers, mixins
├── l10n/  · generated/        # reserved for localization + generated assets
├── app.dart                   # MaterialApp.router + ThemeCubit + responsive frame
├── bootstrap.dart             # composition root (config → DI → runApp)
└── main.dart                  # entrypoint (chooses Env)
```

### Features
`auth`, `onboarding`, `home`, `mood`, `journal`, `feed`, `discovery`, `messaging`,
`notifications`, `profile`, `settings`, `professional`, `shell` (the bottom-tab hosts).

Cross-cutting entities (e.g. `Therapist`, `Appointment`) live in their owning feature
(`discovery`) and are imported read-only by others — pragmatic feature reuse without a
bloated shared kernel.

## State management — Cubit
- Each data-driven screen has a `Cubit` (`@injectable`) with an `Equatable` state using a
  `ViewStatus { initial, loading, loaded, error }` + nullable `Failure`.
- Pages obtain cubits from DI: `BlocProvider(create: (_) => getIt<XCubit>()..load())`.
- Ephemeral form input (controllers, password visibility) stays in the page widget; business
  actions and async results live in the cubit.

## Dependency injection — get_it + injectable
- `lib/core/di/injection.dart` exposes `getIt` and `configureDependencies()` (annotated
  `@InjectableInit`). Registrations are generated into `injection.config.dart`.
- `@lazySingleton` for repositories, data sources, use cases, services; `@injectable`
  (factory) for cubits; `@LazySingleton(as: Interface)` to bind impls to domain interfaces.

## Routing — GoRouter
- All routes are centralized in `routes/app_router.dart`, named via `routes/route_names.dart`.
- `routes/route_guards.dart` redirects unauthenticated access to the shells back to role
  selection.
- The two bottom-tab experiences are widget shells (`UserShellPage`, `ProShellPage`) hosting
  feature tab pages in an `IndexedStack`; pushed detail pages are top-level routes. Tab
  switching from descendants uses `TabScope.maybeOf(context)?.go('journal')`.

## Networking & errors
- `DioClient` centralizes base URL/timeouts and installs `AuthInterceptor` (bearer token),
  `RetryInterceptor` (idempotent transient retry) and `PrettyDioLogger`.
- Data sources throw typed `AppException`s; repositories convert them to `Failure`s via
  `mapErrorToFailure` and wrap results in `Result<T>`.

## Theming
- `MnColors` is a `ThemeExtension` holding the full moss palette for light + dark, read via
  `context.c`. Type scale lives in `MnText` (system UI font + Newsreader serif). Theme mode is
  driven by a persisted `ThemeCubit`.

## Responsiveness
- `_ResponsiveFrame` (in `app.dart`) clamps text scaling and, on wide screens, centers the
  experience in a phone-width column so layouts never stretch awkwardly. Screens use
  `SafeArea` insets (`safeTop`/`safeBottom`) and flexible layouts throughout.

---

## Commands

```bash
flutter pub get                                   # dependencies
dart run build_runner build --delete-conflicting-outputs   # freezed / json / injectable codegen
dart run build_runner watch                       # codegen in watch mode
flutter analyze                                   # static analysis
flutter test                                      # unit / cubit / widget tests
flutter run -d <device>                           # run (e.g. macos, chrome, <emulator id>)
```

Run codegen after changing any `@freezed` model, `@JsonSerializable`, or injectable
annotation.

## Environments
`lib/core/config/env.dart` defines `Env.dev()/staging()/prod()`. `main.dart` selects one and
`bootstrap()` calls `AppConfig.init(env)`. For real deployments inject values via
`--dart-define` and read them in the `Env` factories.

## Firebase (structure, when added)
Firebase is not wired yet. The intended shape:
```
core/services/firebase/firebase_initializer.dart   # Firebase.initializeApp() in bootstrap()
core/services/analytics_service.dart               # abstract + FirebaseAnalytics impl (@LazySingleton(as:))
core/services/crash_reporter.dart                  # abstract + Crashlytics impl
firebase_options.dart                              # generated by flutterfire configure
```
`bootstrap()` would `await Firebase.initializeApp(...)` before `configureDependencies()`.

## Testing
- `mocktail` for mocking repositories/use cases; `bloc_test` for cubit behavior.
- Test layout mirrors `lib/` under `test/`. Domain/use-case tests are pure Dart; cubit tests
  assert emitted states; widget tests pump pages with mocked cubits.

## Migration plan (how this codebase was assembled)
1. **Foundation** — deps, lint config, `core/config`, `core/constants`, bootstrap.
2. **Core** — error layer (Failure/Exception/Result), Dio network stack, services.
3. **Theme + widgets** relocated into `core/`; `shared/` (models, widgets, helpers, mixins).
4. **Routing + DI** — GoRouter (names/guards) and get_it/injectable entrypoint.
5. **Features** — each migrated as a full vertical slice (data → domain → presentation → di).
6. **Integration** — shells, router wiring, app root, codegen, analyze.
7. **Tests + docs**.
