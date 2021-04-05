import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:randomsampleapp/config/app_theme.dart';

class AppTextFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final Widget prefix;
  final int maxLength;
  final TextEditingController textEditingController;

  const AppTextFormField({
    Key key,
    this.title,
    this.prefix,
    this.obscureText = false,
    this.maxLength,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppTheme.background,
              ),
              child: TextField(
                controller: textEditingController,
                maxLength: maxLength,
                obscureText: obscureText,
                decoration: InputDecoration(
                  prefix: prefix,
                  border: InputBorder.none,
                  counterText: '',
                  counterStyle: TextStyle(height: double.minPositive,),
                ),
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
      ),
    );
  }
}
