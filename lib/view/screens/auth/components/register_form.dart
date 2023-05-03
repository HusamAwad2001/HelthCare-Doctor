import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:helth_care_doctor/constants/app_styles.dart';

import '../../../../constants/constants.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _userName, _email, _password, _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "اسم المستخدم"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "حسام عوض دهليز",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            validator: RequiredValidator(errorText: "اسم المستخدم مطلوب"),
            style: getLightStyle(
              color: Colors.black,
            ),
            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),
          // We will fixed the error soon
          // As you can see, it's a email field
          // But no @ on keybord
          const TextFieldName(text: "البريد الإلكتروني"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "test@email.com",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            style: getLightStyle(
              color: Colors.black,
            ),
            validator: EmailValidator(errorText: "تأكد من البريد الإلكتروني!"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "رقم الهاتف"),
          // Same for phone number
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "0595026281",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            style: getLightStyle(
              color: Colors.black,
            ),
            validator: RequiredValidator(errorText: "رقم الهاتف مطلوب"),
            onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "العنوان"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "رفح / شارع الإمام علي",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            validator: RequiredValidator(errorText: "اسم المستخدم مطلوب"),
            style: getLightStyle(
              color: Colors.black,
            ),
            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "تاريخ الميلاد"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "13/12/2001",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            validator: RequiredValidator(errorText: "اسم المستخدم مطلوب"),
            style: getLightStyle(
              color: Colors.black,
            ),
            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "كلمة المرور"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(
              hintText: "******",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            style: getLightStyle(
              color: Colors.black,
            ),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "تأكيد كلمة المرور"),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "*****",
              hintStyle: getLightStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            style: getLightStyle(
              color: Colors.black,
            ),
            validator: (pass) =>
                MatchValidator(errorText: "كلمة السر غير مطابقة")
                    .validateMatch(pass!, _password),
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: getSemiBoldStyle(
          color: Colors.black87,
          fontSize: 12,
        ),
      ),
    );
  }
}
