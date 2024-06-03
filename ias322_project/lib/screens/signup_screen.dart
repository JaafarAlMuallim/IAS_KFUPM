import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ias322_project/app_routes.dart';
import 'package:ias322_project/network/api_client.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _bdate;

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _bdate = picked;
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

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
            'تسجيل جديد',
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
                        TextFormField(
                          style: TextStyle(
                            color: ThemeData.light().colorScheme.onBackground,
                          ),
                          decoration: InputDecoration(
                            fillColor:
                                ThemeData.light().colorScheme.inversePrimary,
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: ThemeData.light().colorScheme.onBackground,
                            ),
                            hintText: 'الاسم الكامل',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: ThemeData.light().colorScheme.onBackground,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء إدخال الاسم الكامل';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: TextStyle(
                              color: ThemeData.light().colorScheme.onBackground,
                              fontFamily: "Poppins"),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone,
                                color:
                                    ThemeData.light().colorScheme.onBackground),
                            hintText: '5XXXXXXXX',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: ThemeData.light().colorScheme.onBackground,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^5\d{8}$').hasMatch(value)) {
                              return 'الرجاء إدخال رقم هاتف صحيح';
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
                            readOnly: true,
                            style: TextStyle(
                              color: ThemeData.light().colorScheme.onBackground,
                            ),
                            controller: _dateController,
                            decoration: InputDecoration(
                              fillColor:
                                  ThemeData.light().colorScheme.inversePrimary,
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color:
                                    ThemeData.light().colorScheme.onBackground,
                              ),
                              hintText: 'تاريخ الميلاد',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color:
                                    ThemeData.light().colorScheme.onBackground,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onTap: () => _selectDate(),
                            validator: (value) => _bdate == null
                                ? 'الرجاء اختيار تاريخ الميلاد'
                                : null),
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
                                await onTapSignUp(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    _phoneController.text,
                                    _bdate,
                                    context);
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
                                  "تسجيل جديد",
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
                              context, AppRoutes.loginScreen),
                          child: Text(
                            "لديك حساب؟ تسجيل الدخول",
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

Future<void> onTapSignUp(
    name, email, password, phone, birthDate, context) async {
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

    final message =
        await apiClient.signUp(name, email, phone, password, birthDate);
    if (kDebugMode) {
      print(message);
    }
    if (message.contains("OK")) {
      Navigator.popAndPushNamed(context, AppRoutes.adviceScreen);
    }
  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print(e);
    }
  } finally {}
}
