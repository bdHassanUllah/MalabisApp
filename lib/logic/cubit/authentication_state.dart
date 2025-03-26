part of 'authentication_cubit.dart';

class AuthenticationState {
  final String? phoneNum;
  final String? otp;
  final QueryResult? numberResult;
  final QueryResult? otpResult;
  final String? otpErro;
  final String? email;
  final String? name;
  final int? userId;
  QueryResult? faqREs;
  String? faqStatus;
  AuthenticationState({
    this.phoneNum,
    this.otp,
    this.numberResult,
    this.otpResult,
    this.otpErro,
    this.email,
    this.name,
    this.userId,
    this.faqREs,
    this.faqStatus
  });

  AuthenticationState copywith({
    final String? phoneNu,
    final String? otpp,
    final QueryResult? numberResultt,
    final QueryResult? otpResultt,
    final String? otpError,
    final String? email,
    final String? name,
    final int? userid,
    QueryResult? faqREss,
    String? faqStatuss,
  }) {
    return AuthenticationState(
      phoneNum: phoneNu ?? phoneNum,
      otp: otpp ?? otp,
      numberResult: numberResultt ?? numberResult,
      otpResult: otpResultt ?? numberResult,
      otpErro: otpError ?? otpErro,
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userid ?? userId,
      faqREs: faqREss ?? faqREs,
      faqStatus: faqStatuss ?? faqStatus
    );
  }
}
