// ignore_for_file: library_private_types_in_public_api, unnecessary_new
import 'package:flutter/material.dart';
import '../../../Controller/extension.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.switchCallback}) : super(key: key);
  final VoidCallback switchCallback;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _usernameController, textInputAction: TextInputAction.next).wrapPaddingTop(20),
              TextField(controller: _passwordController).wrapPaddingTop(20),
              ElevatedButton(onPressed: () {}, child: const Text("Kayıt Ol")).wrapPaddingTop(20),
              ElevatedButton(
                      onPressed: () {
                        widget.switchCallback.call();
                      },
                      child: const Text("Giriş Yapmak İstiyorsun mu?"))
                  .wrapPaddingTop(20),
            ],
          ).wrapPaddingHorizontal(20),
        ),
      ),
    );
  }
}
