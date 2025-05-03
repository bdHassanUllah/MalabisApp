/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:malabis_app/logic/cubit/authentication_cubit.dart';
import 'package:malabis_app/logic/cubit/authentication_state.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/util/config/asset_config.dart';
import 'package:malabis_app/util/constant.dart';
import 'package:malabis_app/views/components/assets_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  double height = 50;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center:CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Color(0xffFE8086),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, bottomNavBar),
                            child: const Text("Skip"),
                          ),
                        ],
                      ),
                      const Center(
                        child: AssetProvider(
                          asset: AssetConfig.kVerifyEmailPageImage,
                          height: 250,
                          width: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: kIsWeb ? 500 : double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "OTP Verification",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xffFE8086),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enter OTP sent to your mobile",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                PinCodeTextField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Code";
                                    } else if (val.length < 4) {
                                      return "Enter Correct OTP";
                                    }
                                    return null;
                                  },
                                  appContext: context,
                                  length: 4,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    inactiveColor: kTextFieldFilledColor,
                                    inactiveFillColor: kTextFieldFilledColor,
                                    selectedColor: kTextFieldFilledColor,
                                    selectedFillColor: kTextFieldFilledColor,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    activeFillColor: Colors.white,
                                  ),
                                  animationDuration:
                                  const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  onCompleted: (v) {
                                    // pro.verifyEmail(context);
                                  },
                                  onChanged: (value) {
                                    context.read<AuthenticationCubit>().otp(value);
                                  },
                                  beforeTextPaste: (text) {
                                    return true;
                                  },
                                ),
                                Text(
                                  state.otpErro!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                          ],
                        ),
                            const SizedBox(
                              height: 30,
                            ),
                            height == 0
                                ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    kUniversalColor),
                              ),
                            )
                                : Center(
                              child: InkWell(
                                onTap: () {
                                    setState(() {
                                      isPressed = true;
                                      Future.delayed(
                                          const Duration(milliseconds: 800),
                                              () {
                                            setState(() {
                                              height = 0;
                                            });
                                          });
                                    });
                                    Future.delayed(const Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            height = 50;
                                            isPressed = false;
                                          });
                                        });
                                  context
                                      .read<AuthenticationCubit>()
                                      .verifyOtp(context);
                                },
                                child: AnimatedContainer(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: kUniversalColor,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  curve: Curves.fastOutSlowIn,
                                  duration: const Duration(milliseconds: 800),
                                  width: isPressed ? 60 : 500,
                                  padding: const EdgeInsets.all(10),
                                  // width: 60,
                                  child: Center(
                                    child: Text(
                                      "Verify",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("if you didn't recieve a OTP!"),
                                TextButton(
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      context
                                          .read<AuthenticationCubit>()
                                          .registerPhone();
                                    }
                                  },
                                  child: const Text("Resend"),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
*/