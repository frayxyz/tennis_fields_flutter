import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../buttons/custom_button.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _passwordRepeat = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu correo';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu telefono';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _phone = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu Contraseñ';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu Contraseñ';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _passwordRepeat = value;
                });
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              "Registrarme",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint('valid form Nombre: $_name, Email: $_email, Teléfono: $_phone, Contraseña: $_password');

                  context.read<AuthenticationBloc>().add(SignUpEvent(email: _email, password: _password, name: _name, phone: _phone));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}