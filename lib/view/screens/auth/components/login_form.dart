import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../../constants/app_styles.dart';
import '../../../../constants/constants.dart';
import 'register_form.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "البريد الإلكتروني"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "استخدم بريدًا إلكترونيًا صالحًا!"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "كلمة المرور"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "******",hintStyle: getLightStyle(
              color: Colors.black54,
              fontSize: 15,
            ),),
            style: getLightStyle(
              color: Colors.black,
            ),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
