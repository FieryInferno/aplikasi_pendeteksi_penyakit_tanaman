import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/input_widget.dart';
import '../components/primary_button.dart';
import '../components/title_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final Map<String, String> _dataUser = {
    'phone_number': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  const TitleWidget(title: 'Masuk'),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputWidget(
                      label: 'Nomor Telepon',
                      onChanged: (value) =>
                          setState(() => _dataUser['phone_number'] = value),
                      validator: (value) => value == ''
                          ? 'Nomor telepon tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    InputWidget(
                      label: 'Kata Sandi',
                      password: true,
                      onChanged: (value) =>
                          setState(() => _dataUser['password'] = value),
                      validator: (value) =>
                          value == '' ? 'Kata sandi tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton('Masuk', onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        var response = await http.post(
                          Uri.https(
                            'toko-dizital.et.r.appspot.com',
                            '/api/v1/auth/login/',
                          ),
                          body: _dataUser,
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
