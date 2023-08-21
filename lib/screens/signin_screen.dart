import 'package:ecart_driver/screens/main_screen.dart';
import 'package:ecart_driver/screens/signup_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:ecart_driver/widgets/text_field_label.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool rememberMe = false;

  var helpingMethod = HelpingMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        const Center(
          child: Text(
            AppConstants.logInTextTitle,
            style: TextStyle(
              fontSize: 30,
              fontFamily: FontConstants.bold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          AppConstants.logInTextDesc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: FontConstants.regular,
          ),
        ),
        const SizedBox(height: 30),
        textFieldLabel(label: AppConstants.emailTextLabel, isRequired: true),
        const SizedBox(height: 16),
        textField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          hintText: AppConstants.emailTextHint,
          controller: emailController,
          focusNode: emailNode,
        ),
        const SizedBox(height: 16),
        textFieldLabel(label: AppConstants.passwordTextLabel, isRequired: true),
        const SizedBox(height: 16),
        textField(
          textInputAction: TextInputAction.done,
          hintText: AppConstants.passwordTextHint,
          controller: passwordController,
          focusNode: passwordNode,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            helpingMethod.openAndReplaceScreen(context: context, screen: const MainScreen());
          },
          child: const Text(
            AppConstants.signInText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontConstants.medium,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: rememberMe,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value!;
                  });
                },
                title: const Text(
                  AppConstants.rememberMeText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontConstants.regular,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                AppConstants.forgotPasswordText,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff0B59ED),
                  fontWeight: FontWeight.w500,
                  fontFamily:FontConstants.medium,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            helpingMethod.openScreen(
                context: context, screen: SignUpScreen());
          },
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: AppConstants.notAccountText,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontConstants.regular,
                  ),
                ),
                TextSpan(
                  text: AppConstants.signUpTextTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
