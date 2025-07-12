import 'package:flutter/material.dart';
import 'package:tcc/components/rounded_button.dart';
import 'package:tcc/components/rounded_input_field.dart';
import 'package:tcc/components/rounded_password_field.dart';
import 'package:tcc/screens/principal/principal.dart';
import 'package:tcc/screens/signup/components/background.dart';

class Body extends StatefulWidget {
  final Widget child;

  const Body({super.key, required this.child});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _grupoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _showValidation = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.blue[300]!, Colors.blue[100]!],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset(
              "assets/icons/png/family-2.png",
              height: size.height * 0.35,
            ),
            Form(
              key: _formKey,
              autovalidateMode: _showValidation
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  RoundedInputField(
                    hintText: "NOME DE USUÁRIO",
                    icon: Icons.person,
                    controller: _nomeController,
                  ),
                  RoundedInputField(
                    hintText: "EMAIL",
                    icon: Icons.email,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return "Informe um email válido";
                      }
                      return null;
                    },
                  ),
                  RoundedInputField(
                    hintText: "GRUPO PARTICIPANTE",
                    icon: Icons.group_rounded,
                    controller: _grupoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                       if (!RegExp(r'^[a-zA-Z]$').hasMatch(value)) {
                        return "Digite apenas uma letra";
                      }
                      return null;
                    },
                  ),
                  RoundedPasswordField(
                    controller: _senhaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                setState(() => _showValidation = true);

                if (_formKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PrincipalScreen(),
                  ));
                }
              },
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
    );
  }
}
