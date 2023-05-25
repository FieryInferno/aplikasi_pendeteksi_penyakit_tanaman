import 'package:flutter/material.dart';
import '/components/input_widget.dart';
import '/components/primary_button.dart';
import '/components/page_wrap.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Edit Profile',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset('assets/images/foto-profile.png'),
                  InputWidget(
                    label: 'Nama',
                    value: 'M. Bagas Setia',
                    controller: _namaController,
                  ),
                  InputWidget(
                    label: 'Nomor Telepon',
                    value: '083895358071',
                    controller: _passwordController,
                  ),
                ],
              ),
            ),
            PrimaryButton('Simpan', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
