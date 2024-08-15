
import 'package:flutter/material.dart';
import 'package:flutterclass/pages/user/viewUsers.dart';
import 'package:flutterclass/repository/user_repo.dart';
import 'package:hexcolor/hexcolor.dart';


class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  UserRepository userRepository = UserRepository();

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Add User',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          backgroundColor: HexColor("#ecd9c9"),
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: _buildAddUser(),

    );
  }

  Widget _buildAddUser() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.brown),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.brown), // Change the color here
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: passwordConfirmationController,
            decoration: InputDecoration(labelText: 'Password Confirmation'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if(nameController.text.isNotEmpty && emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                passwordConfirmationController.text.isNotEmpty &&
                addressController.text.isNotEmpty) {
                  // Dispatch an event to add node
                  int value = await userRepository.registerUser(
                      nameController.text.trim(), emailController.text.trim(),
                      passwordController.text.trim(),
                      passwordConfirmationController.text.trim(),
                      addressController.text.trim());

                  if (value == 0) {
                    // Navigate to HomePage if login is successful
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUsersScreen()),
                    );
                  } else if ( value == 1){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          'The email have been registered')),
                    );
                  } else {
                    // Show error message or handle login failure
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          'Registeration failed. Please try again.')),
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown, // Change the background color here
              ),
              child: Text('Save'),
            ),
          ),

        ],
      ),
    );
  }
}
