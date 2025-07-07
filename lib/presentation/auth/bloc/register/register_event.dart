import 'package:shaftrent/data/model/request/auth/register_request_model.dart';

sealed class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final RegisterRequestModel requestModel;

  RegisterSubmitted({required this.requestModel});
}
