import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/const/AppColors.dart';
import 'package:miaged/ui/login_screen.dart';
import 'package:miaged/ui/user_form.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  signUp()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserForm()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");

      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vinted_color,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(

              width: ScreenUtil().screenWidth,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ],
                ),

            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(child: Image.network("https://firebasestorage.googleapis.com/v0/b/vinted-clone-336fc.appspot.com/o/miaged1.png?alt=media&token=23e005e4-7e09-403e-9604-cfff1ff92c3e",height: 200.h,width: 200.w)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.vinted_color,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "exemple@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.vinted_color,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: AppColors.vinted_color,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "password must be 6 character",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.vinted_color,
                                  ),
                                  suffixIcon: _obscureText == true
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                          )),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        // elevated button
                        Center(
                          child: SizedBox(
                            width: 0.5.sw,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.vinted_color,
                                elevation: 3,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.vinted_color,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
