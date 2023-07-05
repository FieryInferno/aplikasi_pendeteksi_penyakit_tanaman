import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/text_widget.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_view.dart';
import '../../pages/profile/edit_profile.dart';
import '../../data/user_controller.dart';
import '../../components/page_wrap.dart';
import '../../components/input_widget.dart';
import '../../components/primary_button.dart';
import '../../components/alert_widget.dart';
import '../../components/foto_profile_widget.dart';

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
                    onPressed: () => Helpers.redirectPage(
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
                FutureBuilder<Map<String, dynamic>>(
                  future: Helpers.getUser(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;

                      UserController user = UserController(
                        name: data!['name'],
                        phone: data['phone_number'],
                      );

                      return Column(children: [
                        FotoProfileWidget(
                          type: data['image'] != null ? 'network' : 'asset',
                          asset: './assets/images/user.png',
                          url: data['image'],
                        ),
                        InputWidget(
                          label: 'Nama',
                          disabled: true,
                          controller: user.name,
                        ),
                        InputWidget(
                          label: 'Nomor Telepon',
                          disabled: true,
                          controller: user.phone,
                        ),
                      ]);
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          PrimaryButton('Keluar', onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            preferences.clear();
            // ignore: use_build_context_synchronously
            Helpers.redirectPage(context, const AuthView());

            Future.delayed(
              const Duration(milliseconds: 150),
              () => showCustomAlert(
                context,
                message: 'Anda berhasil logout',
                type: 'success',
              ),
            );
          }),
        ],
      ),
    );
  }
}
