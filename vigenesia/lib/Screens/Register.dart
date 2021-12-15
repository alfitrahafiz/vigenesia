import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/Constant/Const.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String baseurl = url;
  Future postRegister(
      String nama, String profesi, String email, String password) async {
    var dio = Dio();
    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };
    try {
      final response = await dio.post("$baseurl/vigenesia/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));
      print("Respon -> ${response.data} + ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register Your Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Form(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: "nama",
                              controller: nameController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(),
                                  labelText: "Nama"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: "profesi",
                              controller: profesiController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(),
                                  labelText: "Profesi"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: "email",
                              controller: emailController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(),
                                  labelText: "Email"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: "password",
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(),
                                  labelText: "Password"),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await postRegister(
                                            nameController.text,
                                            profesiController.text,
                                            emailController.text,
                                            passwordController.text)
                                        .then((value) => {
                                              if (value != null)
                                                {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    Flushbar(
                                                      message:
                                                          "Berhasil Registrasi",
                                                      duration:
                                                          Duration(seconds: 2),
                                                      backgroundColor:
                                                          Colors.greenAccent,
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                    ).show(context);
                                                  })
                                                }
                                              else if (value == null)
                                                {
                                                  Flushbar(
                                                    message:
                                                        "Check Your Field Before Register",
                                                    duration:
                                                        Duration(seconds: 5),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                  ).show(context)
                                                }
                                            });
                                  },
                                  child: Text("Sign In")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
