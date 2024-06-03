import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ias322_project/app_routes.dart';
import 'package:ias322_project/network/api_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: ThemeData.light().colorScheme.primaryContainer,
        elevation: 4.0,
        title: Center(
          child: Text(
            'تسجيل دخول',
            style: TextStyle(
              color: ThemeData.light().colorScheme.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        TextFormField(
                          style: TextStyle(
                            color: ThemeData.light().colorScheme.onBackground,
                          ),
                          decoration: InputDecoration(
                            fillColor:
                                ThemeData.light().colorScheme.inversePrimary,
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: ThemeData.light().colorScheme.onBackground,
                            ),
                            hintText: 'البريد الإلكتروني',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: ThemeData.light().colorScheme.onBackground,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'الرجاء إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: TextStyle(
                            color: ThemeData.light().colorScheme.onBackground,
                          ),
                          decoration: InputDecoration(
                            fillColor:
                                ThemeData.light().colorScheme.inversePrimary,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ThemeData.light().colorScheme.onBackground,
                            ),
                            hintText: 'الرقم السري',
                            errorMaxLines: 4,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: ThemeData.light().colorScheme.onBackground,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء إدخال الرقم السري';
                            } else if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                // r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@#$%^&+=])(?!.*\s).{8,}$")
                                .hasMatch(value)) {
                              return 'الرجاء إدخال رقم سري يحتوي على حروف كبيرة وصغيرة وأرقام ورموز مكون من 8 أحرف على الأقل';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 80),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await onTapLogin(_emailController.text,
                                    _passwordController.text, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ThemeData.light().colorScheme.primary,
                                    ThemeData.light()
                                        .colorScheme
                                        .inversePrimary,
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minHeight: 50,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    color: ThemeData.light()
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () => Navigator.popAndPushNamed(
                              context, AppRoutes.signUpScreen),
                          child: Text(
                            "ليس لديك حساب؟ انشئ حساب الآن",
                            style: TextStyle(
                              color: ThemeData.light().colorScheme.onBackground,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> onTapLogin(email, password, context) async {
  try {
    ApiClient apiClient = ApiClient();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: ThemeData.light().colorScheme.primary,
          ),
        );
      },
    );
    final message = await apiClient.login(email, password);
    if (message.contains("OK")) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.adviceScreen, (route) => false);
    }
  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print(e);
    }
  } finally {}
}
