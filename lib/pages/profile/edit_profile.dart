import 'package:aplikasi_pendeteksi_penyakit_tanaman/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers.dart';
import '../home.dart';
import '/components/input_widget.dart';
import '/components/primary_button.dart';
import '/components/page_wrap.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
                    controller: _phoneNumberController,
                  ),
                ],
              ),
            ),
            PrimaryButton('Simpan', onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              var response = await http.put(
                Uri.https(
                  'toko-dizital.et.r.appspot.com',
                  '/api/v1/auth/edit-profile/',
                ),
                headers: {
                  "Authorization": "Bearer ${preferences.getString('token')}",
                },
                body: {
                  "name": _namaController.text,
                  "phone_number": _phoneNumberController.text,
                },
              );

              if (response.statusCode == 401) {
                preferences.remove('token');
                // ignore: use_build_context_synchronously
                Provider.of<MenuModel>(context, listen: false).setMenu('home');
                // ignore: use_build_context_synchronously
                Helpers().redirectPage(
                  context,
                  Home(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
