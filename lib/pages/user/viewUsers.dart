import 'package:flutter/material.dart';
import 'package:flutterclass/pages/user/editUser.dart';
import 'package:flutterclass/pages/user/registerUser.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/User.dart';
import '../../repository/user_repo.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({Key? key}) : super(key: key);

  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {

  // define list of user
  List<User> userList = [];
  bool _isLoading = true; // Add a loading indicator

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    UserRepository userRepository = UserRepository();
    List<User> users = await userRepository.getAllUsers();
    if (mounted) {
      setState(() {
        userList = users;
        _isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 8.0,
            ),
            Text('User', style: Theme
                .of(context)
                .textTheme
                .bodyText1)
          ],
        ),
        backgroundColor: HexColor("#ecd9c9"),
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: _buildListUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterUserScreen()),
          );
        },
        backgroundColor: HexColor("#3c1e08"),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListUser() {
    return Container(
      color: HexColor("#ecd9c9"),
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final users = userList[index];
          return Container(
            margin:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      users.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      users.email,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      users.address,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserScreen(user: users)),
                      );
                    } else if (value == 2) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ViewNodeServiceScreen(node: nodes)),
                      // );
                    }
                  },
                  itemBuilder: (context) {
                    List<PopupMenuEntry<int>> items = [];
                    items.add(
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.settings, color: Colors.brown),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                    );
                    items.add(
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.settings, color: Colors.brown),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    );
                    return items;
                  },
                  icon: Icon(Icons.more_vert, color: Colors.black),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
