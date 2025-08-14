import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesmeat_app/bloc_login/login_bloc_event.dart';
import 'package:tesmeat_app/bloc_login/login_bloc_state.dart';
import 'package:tesmeat_app/service/login_service.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc({required this.loginService}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final data = await loginService.login(event.username, event.password);
        emit(LoginSuccess(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
        ));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
