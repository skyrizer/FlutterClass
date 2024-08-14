
import 'package:flutter/material.dart';
import 'package:flutterclass/repository/auth_repo.dart';
import 'package:flutterclass/pages/HomePage.dart';


// example of import package
import 'package:hexcolor/hexcolor.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controller for input
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  AuthRepository authRepository = AuthRepository();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                //  it will adjust the space on up and down
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _logoImage(),
                  _logoText(),
                  _usernameField(),
                  const SizedBox(height: 10.0),
                  _passwordField(),
                  _forgotPassword(),
                  _loginButton(),
                  _signUpText(),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _signUpText(){
    return Container(
        child: TextButton(
          onPressed: (){
           // Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen(),));
          },
          child: Text('Don\'t have an account? Sign up here', style: Theme.of(context).textTheme.bodyMedium,),
        )
    );
  }

  Widget _forgotPassword(){
    return Container(
      margin: EdgeInsets.only(top:10.0),
      child:  Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPwd()));
            } ,
            child: Text('Forgot password', style: Theme.of(context).textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),),
          )
      ),
    );
  }

  Widget _logoText(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Stay safe with us', style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget _logoImage(){
    return const Image(
      image: ResizeImage(AssetImage('assets/wafir.jpg'), width: 170),
    );
  }

  Widget _usernameField(){
    return TextFormField(
      controller: usernameController,
      decoration:  InputDecoration(
        prefixIcon: Icon(Icons.person, color: HexColor("#3c1e08"),),
        hintText: 'Username',
        focusColor: HexColor("#3c1e08"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#3c1e08"), width: 1.0,),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#a4a4a4"), width: 1.0,),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _passwordField(){
    return TextFormField(
      obscureText: true,
      controller: pwdController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: HexColor("#3c1e08"),),
        hintText: 'Password',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#3c1e08"), width: 1.0,),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#a4a4a4"), width: 1.0,),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: SizedBox(
        width: 400.0,
        height: 55.0,
        child: ElevatedButton(
          onPressed: () async {
            if (usernameController.text.isNotEmpty && pwdController.text.isNotEmpty) {
              // Call the login method from authRepository instance
              int value = await authRepository.login(
                usernameController.text.trim(),
                pwdController.text.trim(),
              );

              // Handle the result of the login attempt
              if (value == 1) {
                // Navigate to HomePage if login is successful
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else {
                // Show error message or handle login failure
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login failed. Please try again.')),
                );
              }
            } else {
              // Show error message for empty fields
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all fields.')),
              );
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder( borderRadius: BorderRadius.circular(24.0),)
            ),
            backgroundColor: MaterialStateProperty.all<HexColor>(HexColor("#3c1e08")),

          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('SIGN IN', style: TextStyle(fontSize: 16),),
          ),
        ),
      ),
    );
  }
}
