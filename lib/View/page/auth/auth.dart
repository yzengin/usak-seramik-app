// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';

class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  late final ValueNotifier<bool> showRegisterPage = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showRegisterPage,
      builder: (context, value, child) {
        return SizedBox.expand(
          child: showRegisterPage.value
              ? RegisterPage(
                  key: const ValueKey('RegisterPage'),
                  switchCallback: () => showRegisterPage.value = false,
                )
              : LoginPage(
                  key: const ValueKey('LoginPage'),
                  switchCallback: () => showRegisterPage.value = true,
                ),
          // child: PageTransitionSwitcher(
          //   duration: const Duration(milliseconds: 500),
          //   reverse: true,
          //   transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          //     return SharedAxisTransition(
          //       animation: primaryAnimation,
          //       secondaryAnimation: secondaryAnimation,
          //       transitionType: SharedAxisTransitionType.scaled,
          //       fillColor: Colors.black,
          //       child: child,
          //     );
          //   },
          //   child: value
          //       ? LoginPage(
          //           key: const ValueKey('LoginPage'),
          //           switchCallback: () => showRegisterPage.value = true,
          //         )
          //       : RegisterPage(
          //           key: const ValueKey('RegisterPage'),
          //           switchCallback: () => showRegisterPage.value = false,
          //         ),
          // ),
        );
      },
    );
  }
}
