import 'package:nestjs_test_flutter/app/screen/Login/view/login_view.dart';
import 'package:nestjs_test_flutter/app/screen/Root/binding/root_binding.dart';
import 'package:nestjs_test_flutter/app/screen/Root/view/root_screen.dart';
import 'package:nestjs_test_flutter/app/screen/Login/binding/login_binding.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [GetPage(preventDuplicates: true, name: _Paths.LOGIN, page: () => const LoginView(), binding: LoginBinding())],

    ),
  ];
}
// middlewares: [
//   //only enter this route when authed
//   EnsureAuthMiddleware(),
// ],
