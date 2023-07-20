import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginModel loginModel = LoginModel();
  bool isLoginValid=false;
  LoginCubit() : super(LoginInitial());
  void checkValidLoginData() {
    if (loginModel.isDataValid()) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }

}
