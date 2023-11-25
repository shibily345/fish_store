import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? _verificationId;
  bool _verificationSent = false;
  bool _isLoading = false;
  String? _otp;

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          _isLoading = false;
        });

        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationSent = true;
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _otp!,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).indicatorColor),
                onChanged: (value) {
                  _phoneNumber = value;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4)),
                    hintText: 'Enter Your Phone',
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    errorStyle: const TextStyle(fontSize: 18.0),
                    border: InputBorder.none),
              ),
            ),
            if (_verificationSent)
              SizedBox(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'OTP'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _otp = value;
                  },
                ),
              ),
            if (_verificationSent)
              SizedBox(
                child: ElevatedButton(
                  onPressed: _otp != null ? _verifyOTP : null,
                  child: Text('Verify OTP'),
                ),
              ),
            ElevatedButton(
              onPressed: _verificationSent ? null : _sendVerificationCode,
              child: Text('Send Verification Code'),
            ),
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
