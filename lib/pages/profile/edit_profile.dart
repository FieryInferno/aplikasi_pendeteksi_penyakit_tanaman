import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';
import '../../helpers.dart';
import '../../constants.dart';
import '../../model/menu_model.dart';
import '../../model/user_model.dart';
import '../../components/input_widget.dart';
import '../../components/primary_button.dart';
import '../../components/page_wrap.dart';
import '../../components/loading.dart';
import '../../components/foto_profile_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      PageWrapper(
        'Edit Profile',
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Consumer<UserModel>(
                      builder: (context, value, child) => Column(
                        children: [
                          FotoProfileWidget(
                            type: 'network',
                            url: value.user?['image'],
                          ),
                          InputWidget(
                            label: 'Nama',
                            value: value.user?['name'],
                            controller: _namaController,
                          ),
                          InputWidget(
                            label: 'Nomor Telepon',
                            value: value.user?['phone_number'],
                            controller: _phoneNumberController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton('Simpan', onTap: () async {
                setState(() => _isLoading = true);
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                var response = await http.put(
                  Constants.url['editProfile']!,
                  headers: {
                    "Authorization": "Bearer ${preferences.getString('token')}",
                  },
                  body: {
                    "name": _namaController.text,
                    "phone_number": _phoneNumberController.text,
                  },
                );

                setState(() => _isLoading = false);

                if (response.statusCode == 401) {
                  preferences.remove('token');
                  // ignore: use_build_context_synchronously
                  Provider.of<MenuModel>(context, listen: false)
                      .setMenu('home');
                  // ignore: use_build_context_synchronously
                  Helpers().redirectPage(
                    context,
                    Home(),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              }),
            ],
          ),
        ),
      ),
    ];

    if (_isLoading) listWidget.add(const Loading());

    return Stack(children: listWidget);
  }
}
