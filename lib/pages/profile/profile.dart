import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/text_widget.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/helpers.dart';
import 'package:flutter/material.dart';
import '/pages/profile/edit_profile.dart';
import '/components/page_wrap.dart';
import '/components/input_widget.dart';
import '/components/primary_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Profile',
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Helpers().redirectPage(
                      context,
                      const EditProfile(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.edit_square,
                          color: Color(0xFF116531),
                        ),
                        TextWidget(
                          'Edit',
                          color: Color(0xFF116531),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset('assets/images/foto-profile.png'),
                InputWidget(
                  label: 'Nama',
                  value: 'M. Bagas Setia',
                  disabled: true,
                ),
                InputWidget(
                  label: 'Nomor Telepon',
                  value: '083895358071',
                  disabled: true,
                ),
              ],
            ),
          ),
          PrimaryButton('Keluar', onTap: () {}),
        ],
      ),
    );
  }
}
