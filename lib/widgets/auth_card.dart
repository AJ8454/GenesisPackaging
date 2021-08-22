import 'package:flutter/material.dart';
import '../../providers/email_sign_in_provider.dart';
import 'package:provider/provider.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!provider.isLogin) buildUsernameField(),
                    buildEmailField(),
                    buildPasswordField(),
                    if (!provider.isLogin) buildUserNumberField(),
                    SizedBox(height: 12),
                    buildButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildEmailField() {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      key: ValueKey('email'),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      validator: (value) {
        final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value!)) {
          return 'Enter a valid mail';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email address'),
      onSaved: (email) => provider.userEmail = email!,
    );
  }

  buildPasswordField() {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      key: ValueKey('password'),
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return 'Password must be at least 7 characters long';
        } else {
          return null;
        }
      },
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      onSaved: (password) => provider.userPassword = password!,
    );
  }

  buildUsernameField() {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      key: ValueKey('username'),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      enableSuggestions: false,
      validator: (value) {
        if (value!.isEmpty || value.contains(' ')) {
          return 'Please enter your name';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(labelText: 'Name'),
      onSaved: (username) => provider.userName = username!,
    );
  }

  buildUserNumberField() {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      key: ValueKey('userNum'),
      validator: (value) {
        if (value!.isEmpty || value.length < 10 || value.contains(' ')) {
          return 'Please enter your number';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Phone number'),
      onSaved: (userNum) => provider.userNumber = int.parse(userNum!),
    );
  }

  Widget buildButton(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    if (provider.isLoading) {
      return CircularProgressIndicator();
    } else {
      return Column(
        children: [
          buildLoginButton(),
          buildSignpButton(context),
        ],
      );
    }
  }

  Widget buildLoginButton() {
    final provider = Provider.of<EmailSignInProvider>(context);
    return OutlinedButton(
      child: Text(provider.isLogin ? 'Login' : 'Signup'),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: BorderSide(color: Colors.black),
        primary: Colors.red,
      ),
      onPressed: () => submit(),
    );
  }

  Widget buildSignpButton(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: () => provider.isLogin = !provider.isLogin,
      child: Text(provider.isLogin
          ? 'Create new account'
          : 'I already have an account'),
    );
  }

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      final isSuccess = await provider.login();

      if (isSuccess!) {
        Navigator.of(context).pop();
      } else {
        final message = 'An error occurred, please check your credentials!';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }
}
