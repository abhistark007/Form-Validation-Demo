// ignore_for_file: prefer_const_constructors, unused_field, valid_regexps, unnecessary_null_comparison, unnecessary_new

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPasswordCompliant(String? password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
}
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Validation Demo"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              
              decoration: InputDecoration(
                hintText: "Password",
              ),
              validator: (value) {
                if(!isPasswordCompliant(value,8)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Minimum Lenght : 8 \n Should contain atleast 1 special character\n Should contain atleast 1 numeric character \nShould contain atleast 1 uppercase alphabets \n Should contain atleast 1 lowercase alphabets',softWrap: true,)),
                  );
                  return "Password not valid";
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
