import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/primary_button.dart';
import 'package:flutter/material.dart';
import '../helpers.dart';
import '../pages/register.dart';
import '../components/menu.dart';
import '../components/text_widget.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              top: 0,
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
                              child:
                                  Image.asset('assets/images/large-logo.png'),
                            ),
                            const TextWidget(
                              'Masuk untuk mengakses profil',
                              weight: FontWeight.bold,
                              size: 22,
                              color: Color(0xFF116531),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(children: [
                          PrimaryButton('Daftar',
                              onTap: () => Helpers()
                                  .redirectPage(context, const Register())),
                          const SizedBox(height: 10),
                          PrimaryButton('Masuk', onTap: () {}),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Menu(),
          ],
        ),
      ),
    );
  }
}
