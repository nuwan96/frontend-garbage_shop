import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../providers/auth.dart';
import '../../ui/onboarding/registration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var message = await Provider.of<Auth>(context, listen: false)
          .authenicate(_businessName.text, _password.text);
      _showErrorDialog(message);
    } catch (error) {
      // _showErrorDialog(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttonColorDarkGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Text(
            'Welcome !',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: screenSize.height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.blueGrey[200] as Color, blurRadius: 10)
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: screenSize.width,
                minHeight: screenSize.height - 130,
              ),
              child: IntrinsicHeight(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 100),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/killos.png"))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        width: screenSize.width,
                        child: TextFormField(
                          cursorHeight: 30,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 18, height: 1.5),
                          controller: _businessName,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Business Name',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17, height: 1),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _businessName.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _businessName.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _businessName.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _businessName.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        width: screenSize.width,
                        child: TextFormField(
                          cursorHeight: 30,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 18, height: 1.5),
                          controller: _password,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17, height: 1),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _password.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _password.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _password.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: _password.text.isEmpty
                                      ? AppColors.buttonColorLightGrey
                                      : AppColors.buttonColorDarkGreen),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                              ),
                              onPressed: _login,
                              //                     // (){
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                              //                     },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Did not have an account?  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.black,
                            focusColor: Colors.grey,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Registration()));
                            },
                            child: const Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.buttonColorDarkGreen,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
