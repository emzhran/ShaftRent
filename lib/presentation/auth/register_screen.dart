import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent_app/core/components/components.dart';
import 'package:shaft_rent_app/core/components/spaces.dart';
import 'package:shaft_rent_app/core/constants/colors.dart';
import 'package:shaft_rent_app/data/model/request/auth/register_request_model.dart';
import 'package:shaft_rent_app/presentation/auth/register/register_bloc.dart';
import 'package:shaft_rent_app/presentation/auth/register/register_event.dart';
import 'package:shaft_rent_app/presentation/auth/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(100),
                Image.asset(
                  'assets/images/shaft.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
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
                    child: Icon(Icons.person, color: AppColors.white),
                    ),
                  ),
                  const SpaceHeight(16),
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
                    const SpaceHeight(16),
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
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        }, 
                        icon: Icon(
                          isShowPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SpaceHeight(30),
                    BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: AppColors.green
                            )
                          );
                        } else if (state is RegisterFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: AppColors.red
                            )
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          );
                        }
                        return Button.filled(
                          onPressed: (){
                            if (_key.currentState!.validate()) {
                              final request = RegisterRequestModel(
                                nama: namaController.text, 
                                email: emailController.text, 
                                password: passwordController.text,
                              );
                              context.read<RegisterBloc>().add(
                                RegisterSubmitted(requestModel: request)
                              );
                            }
                          },
                          label: "Daftar",
                          color: AppColors.white,
                          textColor: AppColors.primary,
                          borderRadius: 16.0,
                          fontSize: 16,
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
