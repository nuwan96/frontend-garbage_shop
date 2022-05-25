import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../providers/tea_buyer.dart';
import '../../ui/onboarding/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Saved successfully !'),
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

  void _signUp() async {
    try {
      await Provider.of<TeaBuyer>(context, listen: false).addBusiness(
        _businessName.text,
        _address.text,
        _contactNumber.text,
        _email.text,
        _password.text,
      );
      Navigator.of(context).pop(); // print("saved success");
      _showSuccessDialog(_businessName.text + ' business account is created');
    } catch (error) {
      var errorMessage = 'Could not save the data.' + error.toString();
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55), //width and height
          child: SafeArea(
              child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 20,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.buttonColorDarkGrey,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ))),
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
                      const SizedBox(height: 10),
                      const Text(
                        "Create an account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.buttonColorDarkGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/killos.png"))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      oneTextField(
                          screenSize, "Name Of The Business", _businessName),
                      const SizedBox(
                        height: 10,
                      ),
                      oneTextField(
                          screenSize, "Address Of The Business", _address),
                      const SizedBox(
                        height: 10,
                      ),
                      oneTextField(
                          screenSize, "Contact Number", _contactNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      oneTextField(screenSize, "Email", _email),
                      const SizedBox(
                        height: 10,
                      ),
                      oneTextField(screenSize, "Password", _password),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                        ),
                        onPressed: _signUp,
                        child: const Text(
                          "Register",
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
                            "Already have an account?  ",
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
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

  Widget oneTextField(Size screenSize, String labeleName,
      TextEditingController textEditingController) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      width: screenSize.width,
      child: TextFormField(
        cursorHeight: 30,
        style: const TextStyle(color: Colors.green, fontSize: 18, height: 1.5),
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: labeleName,
          labelStyle:
              const TextStyle(color: Colors.grey, fontSize: 17, height: 1),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                width: 2,
                color: textEditingController.text.isEmpty
                    ? AppColors.buttonColorLightGrey
                    : AppColors.buttonColorDarkGreen),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                width: 2,
                color: textEditingController.text.isEmpty
                    ? AppColors.buttonColorLightGrey
                    : AppColors.buttonColorDarkGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                width: 2,
                color: textEditingController.text.isEmpty
                    ? AppColors.buttonColorLightGrey
                    : AppColors.buttonColorDarkGreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                width: 2,
                color: textEditingController.text.isEmpty
                    ? AppColors.buttonColorLightGrey
                    : AppColors.buttonColorDarkGreen),
          ),
        ),
      ),
    );
  }
}
