import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EmailSignInProvider extends ChangeNotifier {
  bool? _isLoading;
  bool? _isLogin;
  String? idToken;
  String? userId;
  String? _userEmail;
  String? _userPassword;
  String? _userName;
  int? _userNumber;

  EmailSignInProvider() {
    _isLoading = false;
    _isLogin = true;
    _userEmail = '';
    _userPassword = '';
    _userName = '';
    _userNumber = 0;
  }

  bool get isLoading => _isLoading!;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLogin => _isLogin!;
  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  String get userEmail => _userEmail!;
  set userEmail(String value) {
    _userEmail = value;
    notifyListeners();
  }

  String get userPassword => _userPassword!;
  set userPassword(String value) {
    _userPassword = value;
    notifyListeners();
  }

  String get userName => _userName!;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  int get userNumber => _userNumber!;
  set userNumber(int value) {
    _userNumber = value;
    notifyListeners();
  }

  Future<bool?> login() async {
    try {
      isLoading = true;
      print(userEmail);
      print(userPassword);

      if (isLogin) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        )
            .then((value) {
          userId = value.user!.uid;
          idToken = value.user!.getIdToken().toString();
          print('userid = $userId');
        });
      } else {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        )
            .then((value) {
          FirebaseFirestore.instance
              .collection('UserData')
              .doc(value.user!.uid)
              .set({
            'email': value.user!.email,
            'Name': userName,
            'PhoneNumber': userNumber,
          });
          userId = value.user!.uid;
          idToken = value.user!.getIdToken().toString();
        });
      }
      isLoading = false;
      return true;
    } catch (error) {
      print(error);
      isLoading = false;
      return false;
    }
  }
}
