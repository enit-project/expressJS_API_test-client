part of 'app_pages.dart';

abstract class Routes {
  /// 메인
  static const ROOT = _Paths.ROOT;

  /// 로그인
  static const LOGIN = _Paths.LOGIN;

  /// 탭
  static const TAB = _Paths.TAB;

  /// 홈
  static const HOME = _Paths.TAB + _Paths.Home;

  ///위치
  static const LOCATIONLIST = _Paths.TAB + _Paths.LOCATIONLIST;

  ///생성
  static const MYPAGE = _Paths.TAB + _Paths.MYPAGE;
}

abstract class _Paths {
  static const ROOT = '/';
  static const LOGIN = '/login';
  static const TAB = '/tab';
  static const Home = '/home';
  static const LOCATIONLIST = '/locationlist';
  static const MYPAGE = '/mypage';
}
