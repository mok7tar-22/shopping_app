import 'package:shopping_app/models/user_data_model.dart';

class LoginModel {
  final bool status;
  final String? message;
  final UserDataModel? data;

  LoginModel({required this.status,  this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserDataModel.fromJson(json['data']) : null);
}
