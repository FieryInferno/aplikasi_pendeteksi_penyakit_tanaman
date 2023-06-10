import 'dart:io';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/pages/profile/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../components/loading.dart';
import '../../helpers.dart';
import '../../components/title_widget.dart';
import '../../components/input_widget.dart';
import '../../components/primary_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  File? fotoProfile;
  late bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() async {
    setState(() => _isLoading = true);

    if (_formKey.currentState!.validate()) {
      var formData = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://toko-dizital.et.r.appspot.com/api/v1/auth/register/',
        ),
      );

      formData.fields.addAll({
        'name': _nameController.text.trim(),
        'phone_number': _phoneNumberController.text.trim(),
        'password': _passwordController.text.trim(),
      });
      formData.files
          .add(await http.MultipartFile.fromPath('image', fotoProfile!.path));

      var response = await formData.send();

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Helpers().redirectPage(context, const Login());
      }

      setState(() => _isLoading = false);
    }
  }

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
                const TitleWidget(title: 'Register'),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Center(
                        child: ClipOval(
                          child: fotoProfile != null
                              ? Image.file(
                                  fotoProfile!,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/user.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      onTap: () {
                        Helpers helpers = Helpers();
                        helpers.showModalImage(context, () async {
                          XFile pickedFile =
                              await Helpers().getImage(context) as XFile;

                          setState(() => fotoProfile = File(pickedFile.path));
                        });
                      },
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
                    const SizedBox(height: 10),
                    PrimaryButton('Daftar', onTap: _submitForm),
                  ]),
            ),
          ],
        ),
      ),
    ];

    if (_isLoading) listWidget.add(const Loading());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: listWidget),
      ),
    );
  }
}
