import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/data/repositories/mock_auth_repository.dart';
import 'feature/domain/usecases/login_usecase.dart';
import 'feature/presentation/Page/login_page.dart';
import 'feature/presentation/bloc/login_bloc.dart';

void main() {
  // Nếu muốn có dependency injection, có thể config ở đây
  final authRepo = MockAuthRepository();
  final loginUseCase = LoginUseCase(authRepo);

  runApp(MyApp(loginUseCase: loginUseCase));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;

  const MyApp({super.key, required this.loginUseCase});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(loginUseCase: loginUseCase),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HR Attendee',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPageWrapper(),
      ),
    );
  }
}

/// LoginPageWrapper để LoginPage không phải tự tạo Bloc, dùng Bloc đã cung cấp từ MyApp
class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage(); // LoginPage sẽ dùng BlocProvider có sẵn từ MyApp
  }
}
