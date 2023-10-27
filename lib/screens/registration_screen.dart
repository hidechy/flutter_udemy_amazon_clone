import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';

import '../extensions/extensions.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: context.screenSize.width * 0.2,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.grey,
                      size: context.screenSize.width * 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textEditingController: nameTextEditingController,
                  iconData: Icons.person,
                  hintText: 'Name',
                  isObsecre: false,
                  enabled: true,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: 'Email',
                  isObsecre: false,
                  enabled: true,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: 'password',
                  isObsecre: false,
                  enabled: true,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  textEditingController: confirmPasswordTextEditingController,
                  iconData: Icons.lock,
                  hintText: 'Confirm Password',
                  isObsecre: false,
                  enabled: true,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {},
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
