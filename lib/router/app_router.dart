import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_test/pages/auth/ui/pages/auth_page.dart';
import 'package:hdi_test/pages/auth/bloc/auth_bloc.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/pages/dashboard/ui/pages/dashboard_page.dart';
import 'package:hdi_test/pages/history/ui/pages/history_page.dart';
import 'package:hdi_test/pages/personalization/ui/pages/personalization_page.dart';
import 'package:hdi_test/router/router_constants.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final router = GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isResolved = authState.status != StatusState.idle;
      final isAuthenticated = authState.isAuthenticated;
      final isOnLogin = state.matchedLocation == RoutePaths.login;
      final isOnSplash = state.matchedLocation == RoutePaths.splash;

      if (isOnSplash) {
        if (!isResolved) return null;
        if (isAuthenticated) return RoutePaths.dashboard;
        return RoutePaths.login;
      }
      if (!isAuthenticated && !isOnLogin) return RoutePaths.login;
      if (isAuthenticated && isOnLogin) return RoutePaths.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RoutePaths.history,
        name: RouteNames.history,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: RoutePaths.personalization,
        name: RouteNames.personalization,
        builder: (context, state) => const PersonalizationPage(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
