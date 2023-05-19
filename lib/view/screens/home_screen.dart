import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/view/base/custom_button.dart';
import 'package:quiz_app/view/screens/create_quiz_screen.dart';
import 'package:quiz_app/view/screens/start_quiz_screen.dart';

import '../../model/user_model.dart';

class HomePage extends StatelessWidget {
  final UserModel user;
  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // AppBar(
            //   backgroundColor: Colors.red,
            // ),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text(user.name),
              accountEmail: Text(user.email),
              currentAccountPicture: Image.asset("assets/profile.png"),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Create Quiz'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateQuizScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text('Start Quiz'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartQuizScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/quiz.png"),
            CustomButton(
                title: 'Lets Start!',
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartQuizScreen()),
                      ),
                    })
          ],
        ),
      ),
    );
  }
}
