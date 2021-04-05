import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomsampleapp/ui/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:randomsampleapp/ui/screens/login/cubit/login_cubit.dart';
import 'package:randomsampleapp/ui/screens/screens.dart';

class Routes {
  static const String initial = '/';
  static const String login = '/login';
  static const String dashBoard = '/dashBoard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: SplashScreen(),
        );

      case login:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: BlocProvider(
            create: (_) => LoginCubit(),
            child: LoginScreen(),
          ),
        );

      case dashBoard:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: BlocProvider(
            create: (_) => DashboardCubit(),
            child: DashBoardScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
  }
}
