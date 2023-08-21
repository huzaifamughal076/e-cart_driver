import 'package:ecart_driver/screens/signin_screen.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final viewModel = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value){
      Get.off(() => const SignInScreen());
    });
    return Scaffold(
      backgroundColor: const Color(0xff1B7575),
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: viewModel.visible.value ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset("images/logo.svg"),
              ),
              const SizedBox(height: 25),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
