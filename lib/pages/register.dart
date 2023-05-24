import 'package:flutter/material.dart';
import '../components/title_widget.dart';
import '../components/input_widget.dart';
import '../components/primary_button.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFE7F0EB),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Color(0xFF116531),
                    ),
                  ),
                  const TitleWidget(title: 'Register'),
                ],
              ),
              Center(child: Image.asset('assets/images/user.png')),
              InputWidget(label: 'Nama'),
              const SizedBox(height: 10),
              InputWidget(label: 'Nomor Telepon'),
              const SizedBox(height: 10),
              InputWidget(label: 'Kata Sandi', password: true),
              const SizedBox(height: 10),
              PrimaryButton('Daftar', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
