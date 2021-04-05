import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomsampleapp/config/configs.dart';
import 'package:randomsampleapp/ui/screens/login/cubit/login_cubit.dart';
import 'package:randomsampleapp/ui/widgets/app_button.dart';
import 'package:randomsampleapp/ui/widgets/app_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneTxtController = TextEditingController();
  TextEditingController _otpTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildCircle(150),
        _buildContainer(),
        _buildTitle(AppStrings.login)
      ],
    );
  }

  Widget _buildCircle(double size) {
    return Positioned(
      top: -70,
      right: -30,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.backgroundLight,
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.black,
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Positioned(
      top: 60,
      left: 120,
      right: 120,
      child: SizedBox(
        height: 40,
        width: 200,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppTheme.primaryColor,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        child: BlocConsumer<LoginCubit, LoginState>(builder: (_, state) {
          print('state id $state');
          if (state is LoginInitial ||
              state is LoginLoading ||
              state is LoginFailed) {
            return _buildPhoneNumber();
          } else if (state is PhoneNumberSubmit || state is CodeSentSuccess) {
            return _buildOtp();
          }
          return CircularProgressIndicator();
        }, listener: (_, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, Routes.dashBoard);
          } else if (state is LoginFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFormField(
          textEditingController: _phoneTxtController,
          title: AppStrings.phoneNumber,
          prefix: Text(
            '+91 ',
            style: TextStyle(color: Colors.white),
          ),
          maxLength: 10,
        ),
        SizedBox(height: 60),
        AppButton(
          title: AppStrings.verifyPhone,
          onPressed: () {
            if (_phoneTxtController.text.isNotEmpty) {
              context
                  .read<LoginCubit>()
                  .verifyPhoneNumber(_phoneTxtController.text);
            }
          },
        )
      ],
    );
  }

  Widget _buildOtp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextFormField(
          textEditingController: _otpTxtController,
          title: AppStrings.otp,
          obscureText: true,
        ),
        SizedBox(height: 60),
        AppButton(
          title: AppStrings.login,
          onPressed: () {
            if (_otpTxtController.text.isNotEmpty) {
              context.read<LoginCubit>().submitCode(
                    phoneNumber: _phoneTxtController.text,
                    smsCode: _otpTxtController.text,
                  );
            }
          },
        )
      ],
    );
  }
}
