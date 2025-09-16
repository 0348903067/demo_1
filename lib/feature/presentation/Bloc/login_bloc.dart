import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../domain/usecases/login_usecase.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });


    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<LoginSubmitted>((event, emit) async {

      if (state.email.trim().isEmpty || state.password.isEmpty) {
        emit(state.copyWith(errorMessage: 'Please enter email and password'));
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      final result = await loginUseCase.call(
        email: state.email,
        password: state.password,
      );

      result.fold(
            (failure) => emit(state.copyWith(
            isSubmitting: false,
            errorMessage: failure.message
        )),
            (_) => emit(state.copyWith(
            isSubmitting: false,
            isSuccess: true
        )),
      );
    });
  }
}