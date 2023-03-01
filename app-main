import 'package:airclean/page2.dart';
import 'package:flutter/material.dart';

// main
void main() {
  return runApp(MaterialApp(
    home: new HomePage(),
  ));
}

// HomePage
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // textEdit bar
  // final TextEditingController account = new TextEditingController();
  // final TextEditingController passwd = new TextEditingController();
  final _account =  TextEditingController();
  final _password =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '登入帳號與密碼',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // body
      body:
      Column(
        children: [
          // 登入帳號密碼
          Container(
            padding: const EdgeInsets.only(top: 50.0, left: 50.0,right: 50.0),
            child: TextField(
              controller: _account,
              style: const TextStyle(fontSize: 40, color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.lightBlueAccent,
                border: InputBorder.none,
                hintText: '帳號',
                hintStyle: TextStyle(color: Colors.white60), ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 50.0, left: 50.0,right: 50.0),
            child: TextField(
              controller: _password,
              style: const TextStyle(fontSize: 40, color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.lightBlueAccent,
                border: InputBorder.none,
                hintText: '密碼',
                hintStyle: TextStyle(color: Colors.white60),
              ),
            ),
          ),

          Container(
              padding: const EdgeInsets.only(top: 50.0, left: 50.0,right: 50.0),
              child:  GestureDetector(
                onTap: () {
                  print('account: ${_account.text}');
                  print('password: ${_password.text}');
                  btnEvent(); },
                child: const Text('登入', style: TextStyle(fontSize: 40, color: Colors.blueAccent),),
              )
          ) // onPressed: btnEvent,), )
        ],
      ),
    );
  }

  void btnEvent() {
    // print(passwd.text);
    if (_password.text == '0000') {
      print('Correct !!! ');

      // /jump to page2
      NavigatorState nav = Navigator.of(context);
      nav.push(MaterialPageRoute(builder: (context)=> Page2())).then((result){
        print(result);
      });
    }
    else {
      print('error ..');
    }
  }
}
