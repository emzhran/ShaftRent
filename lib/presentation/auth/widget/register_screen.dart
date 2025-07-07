import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
    bool isShowPassword = false;
  late final GlobalKey<FormState> _key;

 @override
  void initState() {
    namaController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(100),
                Image.asset(
                  'assets/images/shaft-logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SpaceHeight(40),
                Text(
                  'DAFTAR AKUN BARU',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: AppColors.white
                  ),
                ),
                const SpaceHeight(30),
                CustomTextField(
                  controller: namaController, 
                  label: 'Nama',
                  showLabel: false, 
                  validator: 'Nama tidak boleh kosong',
                  keyboardType: TextInputType.text,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: AppColors.white)
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}