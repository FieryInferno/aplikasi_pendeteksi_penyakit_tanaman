import 'package:flutter/material.dart';
import '/helpers.dart';
import '/pages/register.dart';
import '/pages/login.dart';
import '/components/text_widget.dart';
import '/components/primary_button.dart';
import '/components/page_wrap.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Daun Daunan',
      child: Container(
        color: const Color(0xFFE7F0EB),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Image.asset('assets/images/large-logo.png'),
                    ),
                    const TextWidget(
                      'Masuk untuk mengakses profil',
                      weight: FontWeight.bold,
                      size: 22,
                      color: Color(0xFF116531),
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(children: [
                  PrimaryButton(
                    'Daftar',
                    onTap: () =>
                        Helpers().redirectPage(context, const Register()),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    'Masuk',
                    onTap: () => Helpers().redirectPage(context, const Login()),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
