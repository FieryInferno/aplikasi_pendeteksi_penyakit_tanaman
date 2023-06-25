import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../helpers.dart';
import '../../pages/profile/login.dart';
import '../../components/loading.dart';
import '../../components/title_widget.dart';
import '../../components/input_widget.dart';
import '../../components/primary_button.dart';
import '../../components/alert_widget.dart';
import '../../components/foto_profile_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  File? fotoProfile;
  String? errorPhoneNumber;
  late bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      var formData = http.MultipartRequest(
        'POST',
        Uri.parse('${Constants.url}auth/register/'),
      );

      formData.fields.addAll({
        'name': _nameController.text.trim(),
        'phone_number': _phoneNumberController.text.trim(),
        'password': _passwordController.text.trim(),
      });

      if (fotoProfile != null) {
        formData.files
            .add(await http.MultipartFile.fromPath('image', fotoProfile!.path));
      }

      http.StreamedResponse response = await formData.send();

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Helpers.redirectPage(context, const Login());

        Future.delayed(
          const Duration(milliseconds: 150),
          () => showCustomAlert(
            context,
            message: 'Register berhasil, silahkan melakukan login',
            type: 'success',
          ),
        );
      } else {
        Map body = jsonDecode(await response.stream.bytesToString());
        setState(() => errorPhoneNumber = body['message']['phone_number']);
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: FotoProfileWidget(
                        type: fotoProfile != null ? 'file' : 'asset',
                        file: fotoProfile,
                        asset: 'assets/images/user.png',
                        onTap: () {
                          Helpers.showModalImage(context);
                        },
                      ),
                    ),
                    InputWidget(
                      label: 'Nama',
                      validator: (value) =>
                          value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
                    InputWidget(
                      label: 'Nomor Telepon',
                      validator: (value) => value!.isEmpty
                          ? 'Nomor telepon tidak boleh kosong'
                          : null,
                      controller: _phoneNumberController,
                      errorText: errorPhoneNumber,
                    ),
                    const SizedBox(height: 10),
                    InputWidget(
                      label: 'Kata Sandi',
                      password: true,
                      validator: (value) => value!.isEmpty
                          ? 'Kata sandi tidak boleh kosong'
                          : null,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton('Daftar', onTap: () => _submitForm(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ),
    ];

    if (_isLoading) listWidget.add(const Loading());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: Stack(children: listWidget)),
    );
  }
}
