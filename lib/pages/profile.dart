import 'package:flutter/material.dart';
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
                TextButton(
                  onPressed: () {},
                  child: const Text('Edit'),
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
