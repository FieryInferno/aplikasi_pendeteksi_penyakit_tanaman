import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../helpers.dart';
import '../../pages/profile/login.dart';
import '../../components/loading.dart';
import '../../components/title_widget.dart';
import '../../components/input_widget.dart';
import '../../components/primary_button.dart';
import '../../components/text_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Register createState() => _Register();
}

class _Register extends State<Register> with SingleTickerProviderStateMixin {
  File? fotoProfile;
  late bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _successAlert() {
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: MediaQuery.of(context).size.height * 0.1,
    ).animate(_animationController!);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: SafeArea(
                child: Container(
                  height: _heightAnimation.value,
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.green,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 5),
                            TextWidget(
                              'Success',
                              weight: FontWeight.bold,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextWidget(
                          'Register berhasil, silahkan melakukan login',
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController!.forward();
    // Atur durasi tampilan SnackBar
    Future.delayed(const Duration(seconds: 3), () {
      _animationController!.reverse();

      Future.delayed(const Duration(milliseconds: 400), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

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

      if (fotoProfile != null) {
        formData.files
            .add(await http.MultipartFile.fromPath('image', fotoProfile!.path));
      }

      var response = await formData.send();

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        _successAlert();
        // ignore: use_build_context_synchronously
        Helpers().redirectPage(context, const Login());
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    Center(
                      child: InkWell(
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
                        onTap: () {
                          Helpers helpers = Helpers();
                          helpers.showModalImage(context, () async {
                            XFile pickedFile =
                                await Helpers().getImage(context) as XFile;

                            setState(() => fotoProfile = File(pickedFile.path));
                          });
                        },
                      ),
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
                    const SizedBox(height: 30),
                    PrimaryButton('Daftar', onTap: _submitForm),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ),
    ];

    if (_isLoading) listWidget.add(const Loading());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: Stack(children: listWidget)),
    );
  }
}
