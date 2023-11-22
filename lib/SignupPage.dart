import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';


  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formkey =GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
@override
  void dispose() {
    // TODO: implement dispose
  nameController.dispose();
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  super.dispose();
  }
  signInUser(){
  _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 600,
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up Page',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),

                  MyTextField(text: 'Full Name', icon: const Icon(Icons.person), controller: nameController, yes: false,),
                  MyTextField(text: 'Email', icon: const Icon(Icons.email), controller: emailController, yes: false,),
                  MyTextField(text: 'Password', icon: const Icon(Icons.lock), controller: passwordController, yes: true ,),
                  MyTextField(text: 'Confirm Password', icon: const Icon(Icons.lock), controller: confirmPasswordController, yes: true,),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text('Forgot Password'),
                  ),
                  Container(
                    height: 50,
                    width: 1000,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign up'),
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          signInUser();
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already Have an account ?'),
                      TextButton(
                        child: const Text(
                          'Sign-In',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.yes,
  });

  final String text;
  final Icon icon;
  final bool yes;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        // validator: (value){
        //   if(value!.isEmpty){
        //     return "Please Enter a value";
        //   }
        // },
        obscureText: yes,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: text,
            prefixIcon: icon),
      ),
    );
  }
}
