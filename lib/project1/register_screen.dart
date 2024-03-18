import 'package:blood_donorapp/provider/auth_provider.dart';
import 'package:blood_donorapp/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blood_donorapp/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var phone = '';

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(25.0),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // ignore: prefer_const_constructors
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/image2.jpg'),
                      ),
                      border: Border.all(
                        color: Colors
                            .black, // You can specify the color of the border here
                        width: 2,
                      )),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Give blood. Share life.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.red,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey.shade600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // ignore: non_constant_identifier_names
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550),
                                onSelect: (Value) {
                                  setState(() {
                                    selectedCountry = Value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                      text: "Send Code",
                      onPressed: () async{
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${selectedCountry.phoneCode + phone}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent:
                              (String verificationId, int? resendToken) {},
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        // Navigator.pushNamed(context, "/otp");
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
