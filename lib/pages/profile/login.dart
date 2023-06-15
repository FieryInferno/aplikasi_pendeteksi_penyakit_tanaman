import 'dart:convert';
import 'dart:ui';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/alert_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/menu_model.dart';
import '../home.dart';
import '/helpers.dart';
import '/components/input_widget.dart';
import '/components/primary_button.dart';
import '/components/title_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      Container(
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
                    validator: (value) =>
                        value == '' ? 'Nomor telepon tidak boleh kosong' : null,
                    controller: _phoneNumberController,
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    label: 'Kata Sandi',
                    password: true,
                    validator: (value) =>
                        value == '' ? 'Kata sandi tidak boleh kosong' : null,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton('Masuk', onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _loading = true);

                      var response = await http.post(
                        Uri.https(
                          'toko-dizital.et.r.appspot.com',
                          '/api/v1/auth/login/',
                        ),
                        body: {
                          'phone_number': _phoneNumberController.text.trim(),
                          'password': _passwordController.text.trim(),
                        },
                      );

                      final body = jsonDecode(response.body);

                      if (response.statusCode == 200) {
                        final SharedPreferences preferences =
                            await SharedPreferences.getInstance();

                        await preferences.setString(
                            'token', body['data']['token']);

                        // ignore: use_build_context_synchronously
                        Provider.of<MenuModel>(context, listen: false)
                            .setMenu('home');
                        // ignore: use_build_context_synchronously
                        Helpers().redirectPage(context, Home());
                      } else {
                        // ignore: use_build_context_synchronously
                        showCustomAlert(
                          context,
                          message: body['message']['user'],
                          type: 'error',
                        );
                      }

                      setState(() => _loading = false);
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      )
    ];

    if (_loading) {
      listWidget.add(
        Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 160,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: const [
                      CupertinoActivityIndicator(
                        color: Color(0xFF116531),
                        radius: 40,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Sedang Diproses',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          color: Color(0xFF116531),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: listWidget,
        ),
      ),
    );
  }
}
