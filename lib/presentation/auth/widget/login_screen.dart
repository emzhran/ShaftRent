import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/buttons.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/constants.dart';
import 'package:shaftrent/core/extensions/build_context_ext.dart';
import 'package:shaftrent/data/model/request/auth/login_request_model.dart';
import 'package:shaftrent/presentation/admin/home/homepage_admin_screen.dart';
import 'package:shaftrent/presentation/auth/bloc/login/login_bloc.dart';
import 'package:shaftrent/presentation/auth/bloc/login/login_event.dart';
import 'package:shaftrent/presentation/auth/bloc/login/login_state.dart';
import 'package:shaftrent/presentation/auth/widget/register_screen.dart';
import 'package:shaftrent/presentation/customer/home/homepage_customer_screen.dart';

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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SpaceHeight(230),
                Image.asset(
                  'assets/images/shaft-logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SpaceHeight(30),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  showLabel: false,
                  validator: 'Email tidak boleh kosong',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.email, color: AppColors.white),
                  ),
                ),
                const SpaceHeight(25),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  showLabel: false,
                  obscureText: !isShowPassword,
                  validator: 'Password tidak boleh kosong',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.lock, color: AppColors.white),
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
                      final user = state.responseModel.user;
                      if (role == 'admin'){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomepageAdminScreen(loggedInUser: user!),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.responseModel.message!),
                          backgroundColor: AppColors.green,
                          )
                        );
                      } else if (role == 'customer'){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomepageCustomerScreen(loggedInUser: user!),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.responseModel.message!),
                          backgroundColor: AppColors.green,
                          )
                        );
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
                                email: emailController.text, 
                                password: passwordController.text
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
                      borderRadius: 16,
                      fontSize: 16,
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
                          context.push(const RegisterScreen());
                        }
                      )
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