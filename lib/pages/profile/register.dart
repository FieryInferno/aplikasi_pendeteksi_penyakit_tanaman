import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              InkWell(
                child: Center(
                  child: ClipOval(
                    child: fotoProfile != null
                        ? Image.file(
                            fotoProfile!,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.24,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/user.png',
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.24,
                            fit: BoxFit.cover,
                          ),
                  ),

                  // child: Container(
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  //   height: MediaQuery.of(context).size.height * 0.5,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.amber,
                  //   ),
                  //   child: fotoProfile != null
                  //       ? Image.file(fotoProfile!)
                  //       : Image.asset('assets/images/user.png'),
                  // ),
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
              InputWidget(label: 'Nama'),
              const SizedBox(height: 10),
              InputWidget(label: 'Nomor Telepon'),
              const SizedBox(height: 10),
              InputWidget(label: 'Kata Sandi', password: true),
              const SizedBox(height: 10),
              PrimaryButton('Daftar', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
