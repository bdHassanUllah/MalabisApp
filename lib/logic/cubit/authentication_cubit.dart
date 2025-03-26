import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/logic/repository/authentication_repository.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(AuthenticationState(
          otpErro: "",
          name: "",
          email: "",
          phoneNum: "",
    faqStatus: 'searching'
        ));

  final repository = AuthRepository();

  String phoneNumberVal = '';
  String otpError = '';
  String userId = '';

  String updatedPhone = '';
  String updatedName = '';
  String updatedEmail = '';
  int get getuserID => state.userId == null ? 0000 : state.userId!;
  bool get userIDCanBeNull => state.userId == null ? true : false;

  phoneNumber(String phone) {
    emit(state.copywith(phoneNu: phone));
    phoneNumberVal = phone;
  }

  otp(String otp) {
    emit(
      state.copywith(
        otpp: otp,
      ),
    );
  }

  String get phoneNumberr => state.phoneNum!;

  registerPhone() {
    repository.regitserPhone({
      'source': state.phoneNum,
      'source_type': 1,
    }).then((result) {
      print(result);
      emit(state.copywith(numberResultt: result));
    });
  }

  verifyOtp(BuildContext context) {
    emit(state.copywith(otpError: ""));
    repository.verifyOtp({
      'source': phoneNumberVal,
      'source_type': 1,
      'OTP': int.parse(state.otp!),
    }).then((result) {
      print(result.data);
      print(result.data?['verifyOTP']['firstname'] != null && result.data?['verifyOTP']['firstname'] != '' ? "USer Profile Exist" : "Not Exist");
      if (result.data?['verifyOTP']['is_verified_mobile'] == 1) {
        // valid otp
        var us = result.data?['verifyOTP']['id'].toString();
        userId = us!;
        emit(state.copywith(otpResultt: result, otpError: ""));

        if (result.data?['verifyOTP']['id'] != 0) {
          // user is varified profile
          emit(state.copywith(
              name:
                  "${result.data?['verifyOTP']['firstname']} ${result.data?['verifyOTP']['lastname']}",
              email: result.data?['verifyOTP']['email']));
          Future.delayed(const Duration(seconds: 1), () => saveDataInShared());
          Navigator.pushNamedAndRemoveUntil(
              context, splash, (route) => false);
        } else {
          // user not varified profile
          Navigator.pushNamedAndRemoveUntil(
              context, addProfile, (route) => false);
          // Navigator.pushNamedAndRemoveUntil(context, bottomNavBar, (route) => false);

        }
      } else {
        // invalid Otp
        emit(state.copywith(otpError: "Invalid OTP"));
      }
    });
  }

  assignEmail(String email) {
    emit(state.copywith(email: email));
  }

  assignName(String name) {
    emit(state.copywith(name: name));
  }

  assignUpdateEmail(String email) {
    updatedEmail = email;
  }

  assignUpdateName(String name) {
    updatedName = name;
  }

  assignUpdatePhone(String phone) {
    updatedPhone = phone;
  }

  createProfile() {
    print(state.name);
    print(state.phoneNum);
    print(state.otp);
    print(state.email);
    repository.createProfile(variables: {
      "username": state.name,
      "email": state.email,
      "mobile": state.phoneNum,
      "OTP": int.parse(state.otp!)
    }).then((value){
      print(value);
      var data = value.data?['singupCustomer'];
      userId = data['id'].toString();
      emit(state.copywith(name: "${data['firstname']} ${data['lastname']}",email: data['email'],phoneNu: data['mobile']));
      saveDataInShared();
    });
    // call api

  }

  saveDataInShared() async {
    print(userId);
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('id', userId);
    pre.setString('name', state.name!);
    pre.setString('email', state.email!);
    pre.setString('phone', state.phoneNum!);
    getSharedData();
  }

  getSharedData() async {
    print("called");
    SharedPreferences pre = await SharedPreferences.getInstance();
    print(pre.getString('id'));
    var us = pre.getString('id');
    if(us != null){
      userId = us;
      var name = pre.getString('name');
      var email = pre.getString(
        'email',
      );
      var phone = pre.getString('phone');
      emit(state.copywith(
          userid: int.parse(userId), name: name, email: email, phoneNu: phone));
    }
    print("user id $userId");



  }

  updateProfile(BuildContext context) {
    emit(state.copywith(
        name: updatedName == '' ? state.name : updatedName,
        email: updatedEmail == '' ? state.email : updatedEmail,
        phoneNu: updatedPhone == '' ? state.phoneNum : updatedPhone));
    Map<String, dynamic> variable = {
      'id': int.parse(userId),
      'firstname': state.name,
      'lastname': '',
      'email': state.email,
      'mobile': state.phoneNum,
      'status': 1,
      'customer_group_id': 6,
    };
    // call mutation
    repository.updateProfile(variables: variable).then((value) {
      Fluttertoast.showToast(msg: "Profile Updated");
      // Navigator.pop(context);
    });
    saveDataInShared();
  }

  logout() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.clear();
  }

  getFaq(){
    repository.getFaq().then((value) {
      emit(state.copywith(faqREss: value,faqStatuss: 'loaded'));
    });
  }
}
