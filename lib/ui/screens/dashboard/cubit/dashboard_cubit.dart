import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getrandom/getrandom.dart';
import 'package:meta/meta.dart';
import 'package:randomsampleapp/config/configs.dart';
import 'package:randomsampleapp/data/models/random_number.dart';
import 'package:randomsampleapp/services/firebase_database_service.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DashboardCubit() : super(DashboardInitial());

  Future<void> getRandomNumber() async {
    int randomNumber = await Getrandom.getRandomNumber;
    int previousNumber = await _getPreviousNumber();
    emit(DashboardGetRandomNumber(randomNumber, previousNumber));
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    emit(LoggedOut());
  }

  Future<void> save(int randomNumber, int previous) async {
    RandomNumber random = RandomNumber(
      userId: _firebaseAuth.currentUser.uid,
      randomNumber: randomNumber,
      dateTime: DateTime.now().millisecondsSinceEpoch,
    );

    await serviceLocator<FirebaseDatabaseService>().saveRandomNumber(random);
  }

  Future<int> _getPreviousNumber() async {
    var data = await serviceLocator<FirebaseDatabaseService>().getData();
    if (data != null && data.length > 0) {
      return data.last.randomNumber;
    }
    return 0;
  }
}
