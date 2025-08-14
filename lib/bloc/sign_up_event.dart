
import 'package:equatable/equatable.dart';
import 'package:tesmeat_app/model/user_model.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final UserModel request;

  SignUpSubmitted(this.request);

  @override
  List<Object?> get props => [request];
}
