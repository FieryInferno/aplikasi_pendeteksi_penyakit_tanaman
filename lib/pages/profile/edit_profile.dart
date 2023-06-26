import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/alert_widget.dart';
import '../../helpers.dart';
import '../../constants.dart';
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
  File? fotoProfile;
  String? errorPhoneNumber;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      final formData = http.MultipartRequest(
        'PUT',
        Constants.url['editProfile']!,
      );

      formData.headers['Authorization'] =
          'Bearer ${preferences.getString('token')}';
      formData.fields.addAll({
        'name': _namaController.text.trim(),
        'phone_number': _phoneNumberController.text.trim(),
      });

      if (fotoProfile != null) {
        formData.files
            .add(await http.MultipartFile.fromPath('image', fotoProfile!.path));
      }

      http.StreamedResponse response = await formData.send();
      Map body = jsonDecode(await response.stream.bytesToString());

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Provider.of<UserModel>(context, listen: false).user = body['data'];
        Future.delayed(
          const Duration(milliseconds: 150),
          () => showCustomAlert(
            context,
            message: 'Edit profile berhasil',
            type: 'success',
          ),
        );
      } else {
        setState(() => errorPhoneNumber = body['message']['phone_number']);
      }

      setState(() => _isLoading = false);
    }
  }

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
                            type: fotoProfile != null
                                ? 'file'
                                : value.user?['image'] != null
                                    ? 'network'
                                    : 'asset',
                            file: fotoProfile,
                            url: value.user?['image'],
                            asset: './assets/images/user.png',
                            onTap: () {
                              Helpers.showModalImage(
                                context,
                                onTap: () async {
                                  XFile pickedFile =
                                      await Helpers().getImage() as XFile;

                                  setState(() =>
                                      fotoProfile = File(pickedFile.path));
                                },
                                onTapGallery: () async {
                                  XFile pickedFile =
                                      await Helpers().getImage() as XFile;

                                  setState(() =>
                                      fotoProfile = File(pickedFile.path));
                                },
                              );
                            },
                          ),
                          InputWidget(
                            label: 'Nama',
                            value: value.user?['name'],
                            controller: _namaController,
                            validator: (value) => value!.isEmpty
                                ? 'Nama tidak boleh kosong'
                                : null,
                          ),
                          InputWidget(
                            label: 'Nomor Telepon',
                            value: value.user?['phone_number'],
                            controller: _phoneNumberController,
                            validator: (value) => value!.isEmpty
                                ? 'Nomor telepon tidak boleh kosong'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton('Simpan', onTap: () => _submitForm(context)),
            ],
          ),
        ),
      ),
    ];

    if (_isLoading) listWidget.add(const Loading());

    return Stack(children: listWidget);
  }
}
