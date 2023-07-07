import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile.dart';
import '../../components/alert_widget.dart';
import '../../helpers.dart';
import '../../constants.dart';
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
  String? urlImage;

  void _submitForm(BuildContext context) async {
    debugger();
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
        Helpers.redirectPage(context, const Profile());
        preferences.setString('user', jsonEncode(body['data']));
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
        setState(() => _isLoading = false);
      }
    }
  }

  void _changePhotoProfile() => Helpers.showModalImage(
        context,
        onTap: () async {
          XFile pickedFile = await Helpers().getImage() as XFile;

          setState(() => fotoProfile = File(pickedFile.path));
        },
        onTapGallery: () async {
          XFile pickedFile = await Helpers().getImage() as XFile;

          // setState(() => fotoProfile = File(pickedFile.path));
        },
      );

  Future<void> fetchData() async {
    final data = await Helpers.getUser();
    final user = data['data'];

    _namaController.text = user['name'];
    _phoneNumberController.text = user['phone_number'];

    setState(() => urlImage = user['image']);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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
                    FotoProfileWidget(
                      type: fotoProfile != null
                          ? 'file'
                          : urlImage != null
                              ? 'network'
                              : 'asset',
                      file: fotoProfile,
                      asset: './assets/images/user.png',
                      url: urlImage,
                      onTap: _changePhotoProfile,
                    ),
                    InputWidget(
                      label: 'Nama',
                      controller: _namaController,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                    ),
                    InputWidget(
                      label: 'Nomor Telepon',
                      controller: _phoneNumberController,
                      validator: (value) => value!.isEmpty
                          ? 'Nomor telepon tidak boleh kosong'
                          : null,
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
