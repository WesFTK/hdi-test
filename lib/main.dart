import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hdi_test/core/theme/app_theme.dart';
import 'package:hdi_test/core/theme/theme_cubit.dart';
import 'package:hdi_test/pages/auth/bloc/auth_bloc.dart';
import 'package:hdi_test/pages/auth/repository/auth_repository.dart';
import 'package:hdi_test/pages/dashboard/repository/dashboard_repository.dart';
import 'package:hdi_test/router/app_router.dart';
import 'package:hdi_test/utils/local_storage/local_storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  Bloc.observer = TalkerBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<MemberRepository>(create: (_) => MemberRepository()),
        RepositoryProvider<TransactionRepository>(create: (_) => TransactionRepository()),
      ],
      child: BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(), child: const _AppView()),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  static const _designSize = Size(390, 844);

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(authRepository: context.read<AuthRepository>());
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final view = View.of(context);
          final logicalWidth = view.physicalSize.width / view.devicePixelRatio;
          final isTablet = logicalWidth >= 600;
          return ScreenUtilInit(
            designSize: _designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            // on tablet: .w/.h/.r return raw logical pixels (no scaling)
            // on phone: .w/.h/.r scale from Figma baseline as normal
            enableScaleWH: () => !isTablet,
            fontSizeResolver: (fontSize, instance) {
              final scale = min(
                instance.screenWidth / _designSize.width,
                instance.screenHeight / _designSize.height,
              ).clamp(0.85, 1.3);
              return fontSize * scale;
            },
            builder: (context, child) => MediaQuery.withClampedTextScaling(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.3,
              child: MaterialApp.router(
                title: 'Member Dashboard',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                routerConfig: _appRouter.router,
              ),
            ),
          );
        },
      ),
    );
  }
}
