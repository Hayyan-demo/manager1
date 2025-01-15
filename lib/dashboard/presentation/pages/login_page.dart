// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';
import 'package:order_delivery_manager/core/util/functions/functions.dart';
import 'package:order_delivery_manager/core/util/variables/global_variables.dart';
import 'package:order_delivery_manager/dashboard/presentation/pages/home_page.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_button.dart';
import 'package:order_delivery_manager/dashboard/presentation/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginForm = GlobalKey();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  bool loadingLogin = false;
  @override
  void dispose() {
    phoneTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 103, 1, 121),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            const Text(
              "Hello, Admin!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.purpleAccent.withAlpha(70),
                    border: Border.all(color: Colors.purpleAccent),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                height: 200,
                width: 400,
                child: SingleChildScrollView(
                  child: Form(
                    key: loginForm,
                    child: Column(
                      spacing: 10,
                      children: [
                        ..._buildTextFields(),
                        _buildDoneButton(),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return <Widget>[
      CustomTextFormField(
          textEditingController: phoneTEC,
          hintText: 'Enter your phone number',
          validator: (value) => _defaultValidator(value),
          prefixIcon: const Icon(
            Icons.phone,
            color: Colors.lightBlue,
          )),
      CustomTextFormField(
          textEditingController: passwordTEC,
          obscured: true,
          hintText: 'Enter your password',
          validator: (value) => _defaultValidator(value),
          prefixIcon: const Icon(
            Icons.password,
            color: Colors.lightBlue,
          ))
    ];
  }

  Widget _buildDoneButton() {
    return CustomButton(
        height: 50,
        width: 200,
        onPressed: loadingLogin
            ? null
            : () async {
                setState(() {
                  loadingLogin = true;
                });
                if (loginForm.currentState!.validate()) {
                  try {
                    await authService.login(
                        phoneTEC.text.trim(), passwordTEC.text.trim());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  } catch (e) {
                    showCustomAboutDialog(context, "Login error", e.toString(),
                        type: ERROR_TYPE);
                  }
                }
                setState(() {
                  loadingLogin = false;
                });
              },
        color: Colors.blue,
        child: loadingLogin
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ));
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please fill this text field to continue";
    }
    return null;
  }
}
