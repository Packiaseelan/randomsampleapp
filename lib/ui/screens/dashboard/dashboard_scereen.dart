import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:randomsampleapp/config/configs.dart';
import 'package:randomsampleapp/ui/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:randomsampleapp/ui/widgets/app_button.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _randomNumber, _previous;
  @override
  void initState() {
    super.initState();
  }

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
        _buildTitle(AppStrings.plugin)
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
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: InkWell(
                onTap: () {
                  context.read<DashboardCubit>().logout();
                },
                child: Text(
                  AppStrings.logout,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 60),
              _buildCurrentRandomNumber(),
              SizedBox(height: 60),
              _buildPreviousRandomNumber(),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppButton(
                  title: AppStrings.save,
                  onPressed: () {
                    context
                        .read<DashboardCubit>()
                        .save(_randomNumber, _previous);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.saveSuccess),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentRandomNumber() {
    return BlocConsumer<DashboardCubit, DashboardState>(
      builder: (_, state) {
        if (state is DashboardInitial) {
          context.read<DashboardCubit>().getRandomNumber();
        }
        if (state is DashboardGetRandomNumber) {
          _randomNumber = state.currentRandomNumber;
          _previous = state.previousRandomNumber;
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 170,
                child: _buildGeneratedBg(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Column(
                  children: [
                    _buildQrCode(state.currentRandomNumber.toString(), 200),
                    SizedBox(height: 20),
                    Text(
                      AppStrings.generatedNumber,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${state.currentRandomNumber}',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(letterSpacing: 5),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
      listener: (_, state) {
        if (state is LoggedOut) {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        }
      },
    );
  }

  Widget _buildPreviousRandomNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardGetRandomNumber) {
            String previous = state.previousRandomNumber == 0
                ? 'No data'
                : state.previousRandomNumber.toString();
            return Container(
              height: 140,
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: AppTheme.bgColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 20,
                    height: 120,
                    width: 120,
                    child: _buildQrCode(previous, 100),
                  ),
                  Positioned(
                    top: 20,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppStrings.previouslyScanned,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: AppTheme.primaryTextColorLight),
                            ),
                            Text(
                              previous,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(letterSpacing: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildQrCode(String data, double size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: AppTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: QrImage(
          data: data,
          size: size,
          version: QrVersions.auto,
          backgroundColor: AppTheme.white,
        ),
      ),
    );
  }

  Widget _buildGeneratedBg() {
    return Stack(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppTheme.background,
          ),
        ),
        CustomPaint(
          painter: Chevron(),
          child: Container(
            height: 170,
          ),
        )
      ],
    );
  }
}

class Chevron extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()..color = AppTheme.bgColor;

    Path path = Path();
    path.moveTo(0, 10);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 10, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
