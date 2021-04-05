import 'package:flutter/material.dart';
import 'package:randomsampleapp/config/app_theme.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const AppButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: AppTheme.buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          )),
    );
  }
}
