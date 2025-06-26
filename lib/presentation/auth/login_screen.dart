import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent_app/core/components/buttons.dart';
import 'package:shaft_rent_app/core/components/custom_text_field.dart';
import 'package:shaft_rent_app/core/components/spaces.dart';
import 'package:shaft_rent_app/core/constants/colors.dart';
import 'package:shaft_rent_app/core/extensions/build_context_ext.dart';
import 'package:shaft_rent_app/data/model/request/auth/login_request_model.dart';
import 'package:shaft_rent_app/presentation/auth/login/login_bloc.dart';
import 'package:shaft_rent_app/presentation/auth/login/login_event.dart';
import 'package:shaft_rent_app/presentation/auth/login/login_state.dart';
import 'package:shaft_rent_app/presentation/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _key.currentState?.dispose();
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(230),
                Image.asset(
                  'assets/images/shaft.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SpaceHeight(30),
                CustomTextField(
                  controller: emailController, 
                  label: 'Email', 
                  validator: 'Email tidak boleh kosong',
                  showLabel: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.email, color: AppColors.white),
                  ),
                ),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  showLabel: false,
                  obscureText: !isShowPassword,
                  validator: 'Password tidak boleh kosong',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.password, color: AppColors.white),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    icon: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SpaceHeight(30),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    } else if (state is LoginSuccess) {
                      final role = state.responseModel.user?.role?.toLowerCase();
                      if (role == 'admin'){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.responseModel.message!),
                          backgroundColor: AppColors.green
                          ),
                        );
                        //navigasi halaman admin (progress)
                      } else if (role == 'customer') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.responseModel.message!),
                            backgroundColor: AppColors.green
                          ),
                        );
                        //navigasi halaman customer (progress)
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      );
                    }
                    return Button.filled(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                            if (_key.currentState!.validate()) {
                              final request = LoginRequestModel(
                                email : emailController.text,
                                password : passwordController.text
                              );
                              context.read<LoginBloc>().add(
                                LoginRequested(requestModel: request)
                              );
                            }
                          }, 
                      label: 'Masuk',
                      height: 50,
                      color: AppColors.white,
                      textColor: AppColors.primary,
                      borderRadius: 16.0,
                      fontSize: 16
                    );
                  },
                ),
                const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: 'Belum memiliki akun? Silahkan ',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftar disini',
                        style: TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(const RegisterScreen()
                          );
                        }
                      ),
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
