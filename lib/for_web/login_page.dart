import 'package:flutter/material.dart';
import 'package:inspection_app/for_web/service/login_service.dart';
import 'package:inspection_app/for_web/widgets/appconstant.dart';
import 'package:inspection_app/for_web/widgets/common_toast_message.dart';
import 'navigator_bar_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String _errorMessage = '';
  bool _obscureText = true;
  Map loginDetails = {};

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    Map<String, dynamic> body = {
      "mobile_number": username.toLowerCase(),
      "password": password.toString(),
    };

    try {
      final response = await LoginService.loginPostMethod(body);
      loginDetails = response;
      if (!mounted) return;
      SnackBarUtils.successMessageBar(context, "Login Successful");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => SideNavigationBarScreen(loginPersonName: username),
        ),
      );
    } catch (e) {
      SnackBarUtils.errorMessageBar(context, "$e");
      _errorMessage = 'Login failed: $e';
    }
    setState(() {
      isLoading = false;
    });
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/images/logo.jpg',
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "INSPECTION APP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Login into your account",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(height: 20),
                              buildTextField(
                                controller: _usernameController,
                                name: "Mobile Number",
                              ),
                              const SizedBox(height: 20),
                              buildTextField(
                                controller: _passwordController,
                                name: "Password",
                                passwordHide: true,
                              ),
                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 20,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                        value: false,
                                        onChanged: (val) {},
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text("Remember me"),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Password",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: _login,
                                child:
                                    isLoading
                                        ? CircularProgressIndicator()
                                        : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue.shade100,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            color: AppColors.primary,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Login in",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                              ),

                              if (_errorMessage.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    _errorMessage,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/images/login_image.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField({
    TextEditingController? controller,
    String? name,
    String? hint,
    bool? passwordHide = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: passwordHide! ? _obscureText : false,
      decoration: InputDecoration(
        filled: true,
        suffixIcon:
            passwordHide
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 15,
                  ),
                  onPressed: _togglePasswordView,
                )
                : SizedBox(),
        fillColor: Color(0xFFF2F2F2),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.blue),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.black26),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),

        labelText: name,
      ),
    );
  }
}
