# Member Dashboard App

A Flutter mobile + tablet app for members to log in, view their dashboard, and inspect purchase history.

---

## Flutter Version

```
Flutter 3.41.4
Dart 3.11.1
```

---

## Getting Started

### Install dependencies

```bash
flutter pub get
```

### Run code generation (freezed + json_serializable)

```bash
dart run build_runner build
```

### Run the app

```bash
flutter run
```

---

## Mock Credentials

| Field      | Value           |
|------------|-----------------|
| Member ID  | `MB001`         |
| Password   | `password123`   |

> A valid email address also works as the identifier (paired with `password123`).

---

## Packages Used

| Package | Purpose |
|---------|---------|
| `flutter_bloc` / `bloc` | State management (BLoC + Cubit pattern) |
| `go_router` | Declarative navigation with auth-based redirect |
| `hive_ce` / `hive_ce_flutter` | Local storage — persist login session and theme preference |
| `result_dart` | Repository error handling via `AsyncResult<T>` instead of exceptions |
| `freezed` + `freezed_annotation` | Immutable models and BLoC state/event classes |
| `json_annotation` + `json_serializable` | JSON serialization for models |
| `flutter_form_builder` + `form_builder_validators` | Login form with built-in validation |
| `flutter_screenutil` | Pixel-perfect sizing from 390×844 phone Figma baseline — font scaling clamped via `fontSizeResolver` |
| `responsive_builder` | Screen-type breakpoints (`ScreenTypeLayout.builder`) for mobile/tablet layout switching |
| `gap` | Spacing widgets |
| `shimmer` | Skeleton loading UI |
| `google_fonts` | Poppins (headings) + Inter (body) typefaces |
| `another_flushbar` | Error toast on login failure |
| `fl_chart` | Monthly spend bar chart on dashboard |
| `intl` | Date and currency formatting |
| `talker_bloc_logger` | BLoC event/state logging for debugging |

---

## Architecture

```
lib/
├── core/
│   └── theme/               # AppTheme, AppColors, AppTypography, AppThemeExtension, ThemeCubit
├── models/                  # Freezed data models (MemberModel, TransactionModel)
├── pages/
│   ├── auth/
│   │   ├── bloc/            # AuthBloc, AuthEvent, AuthState
│   │   ├── repository/      # AuthRepository
│   │   └── ui/
│   │       ├── pages/       # AuthPage
│   │       └── widgets/     # AuthBrandPanel, AuthAppIcon
│   ├── dashboard/
│   │   ├── bloc/            # DashboardBloc, DashboardEvent, DashboardState
│   │   ├── repository/      # MemberRepository
│   │   └── ui/
│   │       ├── pages/       # DashboardPage
│   │       └── widgets/     # MemberInfoCard, SpendChart, RecentTile
│   ├── history/
│   │   ├── bloc/            # HistoryBloc, HistoryEvent, HistoryState
│   │   └── ui/
│   │       ├── pages/       # HistoryPage
│   │       └── widgets/     # FilterSidePanel, MonthFilterBar, ChipFilterRow, FilterChipItem
│   └── personalization/
│       └── ui/
│           ├── pages/       # PersonalizationPage
│           └── widgets/     # ThemeSelector, ThemeOptionTile
├── repositories/            # Shared TransactionRepository
├── router/                  # GoRouter setup with auth-based redirect
├── utils/
│   ├── enums/               # StatusState, TransactionStatus, TransactionCategory
│   ├── extensions/          # BuildContext helpers (colorScheme, textTheme)
│   ├── local_storage/       # LocalStorage wrapper over Hive
│   ├── mock_data/           # Static mock data (18 transactions, 1 member)
│   ├── ui/                  # AppFlushbar
│   └── utils_function.dart  # UtilsFunction — formatCurrency, formatDate, calcMonthPaid, last6MonthsSpend
├── widgets/                 # Reusable widgets: SummaryCard, TransactionTile, SectionHeader, ShimmerBox
└── main.dart                # App entry point + ScreenUtil adaptive design size
```

### Widget placement rules

| Location | What goes here |
|----------|----------------|
| `lib/widgets/` | Truly reusable widgets — no page-specific logic, usable across multiple features (`SummaryCard`, `TransactionTile`, `SectionHeader`) |
| `pages/<feature>/ui/widgets/` | Widgets used only by that feature's page (e.g., `SpendChart` is dashboard-only, filter chips are history-only) |
| `pages/<feature>/ui/pages/` | The page entry point — composes widgets and connects the BLoC |

**State management:** Each page owns a scoped BLoC. `AuthBloc` is created and disposed by `_AppViewState`, exposed via `BlocProvider.value`. `ThemeCubit` lives at the app root and drives `MaterialApp` theme. All BLoC states use a single-class freezed pattern with a `StatusState` enum (`idle`, `loading`, `loaded`, `error`). All BLoCs route events through a single `on<Event>(_onEvent)` handler using `event.when(...)` dispatch.

**Theme:** `AppColors` defines typed color tokens (`AppColorScheme`) for light and dark modes. `AppTypography` maps Poppins + Inter to the full Material `TextTheme`. `AppThemeExtension` (a `ThemeExtension<T>`) injects shimmer colors into the theme tree. No `isDark` boolean checks exist in widget code — all color decisions use `Theme.of(context).colorScheme` tokens.

**Responsive layout:** `ScreenTypeLayout.builder` switches between mobile and tablet layouts at 600dp. Two concerns are handled separately:

- **Layout switching** — `responsive_builder` at 600dp breakpoint. Mobile and tablet have completely separate widget trees.
- **Size scaling** — `flutter_screenutil` with `Size(390, 844)` as the phone Figma baseline. `.w/.h/.sp/.r` in mobile layout code scale relative to this canvas.

Tablet layout code uses **plain logical pixels** (no `.w/.h` suffix) since no tablet Figma exists — tablet layout is "best effort" proportional design using `Expanded` with `flex` ratios and fixed dp values.

**Font size scaling (`fontSizeResolver`):**

```dart
fontSizeResolver: (fontSize, instance) {
  final scale = min(
    instance.screenWidth / _designSize.width,   // width ratio
    instance.screenHeight / _designSize.height, // height ratio
  ).clamp(0.85, 1.3);
  return fontSize * scale;
},
```

- `min(scaleWidth, scaleHeight)` — takes the smaller of the two ratios. On a tablet (1280×800), width ratio = 3.28x but height ratio = 0.95x, so `min()` picks 0.95x. Prevents font blowup on wide screens and landscape mode.
- `.clamp(0.85, 1.3)` — hard floor and ceiling. Prevents fonts from going below 85% of design size (very small screens / landscape) or above 130% (edge cases).
- Without this override, ScreenUtil's default `.sp` uses width-only scaling — 3.28x on tablet = unreadably large text.

**System font scale (`MediaQuery.withClampedTextScaling`):**

```dart
MediaQuery.withClampedTextScaling(
  minScaleFactor: 0.8,
  maxScaleFactor: 1.3,
  child: MaterialApp.router(...),
)
```

When a user sets a large font in device Settings → Display → Font Size, Flutter's `TextScaler` multiplies all text sizes. Fixed-height containers then overflow. Clamping at 1.3x respects accessibility preferences while keeping layouts intact. `minScaleFactor: 0.8` prevents overly tiny text on devices set to the smallest font size.

**`View.of(context)` rebuild behavior:** Called inside `BlocBuilder`'s builder, so the widget registers a dependency on `FlutterView`. It rebuilds when physical screen size or device pixel ratio changes — concretely: device rotation or desktop window resize. On a typical phone/tablet this is ~2 events per app lifetime (startup + one rotation). Not a performance concern — it's the correct signal for recalculating `isTablet`. The alternative (calculating once in `initState`) would silently show the wrong layout after rotation.

**If a tablet Figma exists:** replace the single `designSize` with adaptive detection using `View.of(context)` before `ScreenUtilInit` is constructed (safe because it reads the platform view, not ScreenUtil itself). Remove `fontSizeResolver` — two correct baselines mean no override is needed.

```dart
builder: (context, themeMode) {
  final view = View.of(context);
  final logicalWidth = view.physicalSize.width / view.devicePixelRatio;
  final isTablet = logicalWidth >= 600;
  return ScreenUtilInit(
    designSize: isTablet ? const Size(1024, 768) : const Size(390, 844),
    minTextAdapt: true,
    builder: (context, child) => MaterialApp.router(...),
  );
},
```

Phone (390×844 Figma) → scale = 1.0x on a 390px device, pixel-perfect.
Tablet (1024×768 Figma) → scale = 1.0x on a 1024px device, pixel-perfect.
Each form factor matches its own design baseline with no manual overrides.

**Navigation:** `go_router` uses a `GoRouterRefreshStream` on `AuthBloc.stream` so redirects re-evaluate on every auth state change.

**Session persistence:** `AuthBloc` self-dispatches `AppStarted` on construction, which reads an `isLoggedIn` flag from Hive synchronously. No async wait before the first route renders.

**Error handling:** Repositories return `AsyncResult<T>` (from `result_dart`) instead of throwing. BLoCs fold the result into success or error states.

---

## Features

- **Login** — Member ID or valid email + password, form validation, FlushBar error toast, cooldown to prevent spam
- **Dashboard** — Member info card, 3 summary cards (paid this month, last transaction, membership status), 6-month spend bar chart, recent transactions list, pull-to-refresh
- **Purchase History** — Reactive multi-filter (month, status, category) — all filters compose, results update immediately
- **Personalization** — Dark / Light / System theme selection, persisted across restarts
- **Logout** — Clears session, returns to login
- **Shimmer loading** — Skeleton UI on every data screen
- **Empty state** — Shown when filters yield no results
- **Error state** — Retry button on fetch failure
- **Tablet layout** — Two-column dashboard, sidebar filter panel in history, split branding/form auth screen

---

## Assumptions & Tradeoffs

- All data is in-memory mock data. Repositories add a 500 ms artificial delay to make shimmer visible.
- Session uses a boolean flag in Hive (sufficient for mock auth; a real app would store a signed token).
- `result_dart` is used with `AsyncResult<T>` = `Future<ResultDart<T, Exception>>`. The `fold` pattern keeps BLoC handlers free of try/catch.
- Each feature page lives under `pages/<feature>/ui/pages/` and `ui/widgets/`. No barrel exports — router imports the canonical paths directly.

---

## Tests

### Run all tests

```bash
flutter test
```

### Test coverage

| File | What is tested |
|------|----------------|
| `test/repositories/auth_repository_test.dart` | Login with member ID, email, wrong password, empty password; session persist/clear via Hive |
| `test/blocs/auth_bloc_test.dart` | Constructor auto-dispatches `AppStarted` → authenticated/unauthenticated; `LoginSubmitted` → loading+authenticated or loading+error; `LogoutRequested` → unauthenticated |
| `test/blocs/history_bloc_test.dart` | `LoadHistory` emits full list; `FilterChanged` by status, category, month, combined filters, and clearing filters |

Tests use `bloc_test` for BLoC state assertions and `mocktail` for repository mocking.
