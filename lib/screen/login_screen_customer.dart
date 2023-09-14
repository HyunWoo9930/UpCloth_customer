import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:upcloth/screen/main_screen.dart';

class LoginScreenCustomer extends StatelessWidget {
  const LoginScreenCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('upcloth'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '업클로스 방문을 환영합니다!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          _IdPwd(),
          _loginButton(),
          _convenient_login(),
        ],
      ),
    );
  }
}

class _IdPwd extends StatefulWidget {
  const _IdPwd({super.key});

  @override
  State<_IdPwd> createState() => _IdPwdState();
}

class _IdPwdState extends State<_IdPwd> {
  bool _isChecked = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              )),
          TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '*****',
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: _isChecked,
                  onChanged: (bool? val) {
                    if (val != null) {
                      setState(() {
                        _isChecked = val;
                      });
                    }
                  }),
              Text(
                '자동 로그인',
                style: TextStyle(fontSize: 30.0),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {},
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: _login,
                child: const Text(
                  '로그인',
                  style: TextStyle(fontSize: 30.0),
                ),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: () {
                  print('아이디 찾기 클릭!!');
                },
                child: Text('아이디 찾기')),
            TextButton(
                onPressed: () {
                  print('비밀번호 찾기 클릭!!');
                },
                child: Text('비밀번호 찾기')),
            TextButton(
                onPressed: () {
                  print('회원가입 클릭!!');
                },
                child: Text('회원가입')),
          ]),
        ],
      ),
    );
  }

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 입력해주세요.')),
      );
    } else if (username != 'test_id' || password != 'test_pw') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 확인해주세요.')),
      );
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    }
    return;
  }
}

class _loginButton extends StatefulWidget {
  const _loginButton({super.key});

  @override
  State<_loginButton> createState() => _loginButtonState();
}

class _loginButtonState extends State<_loginButton> {
  @override
  Widget build(BuildContext context) {
    return Column(children: []);
  }
}

class _convenient_login extends StatefulWidget {
  const _convenient_login({super.key});

  @override
  State<_convenient_login> createState() => _convenient_loginState();
}

class _convenient_loginState extends State<_convenient_login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '간편 로그인',
          style: TextStyle(fontSize: 25.0),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            onPressed: naverLogin,
            icon: Ink.image(
              image: AssetImage(
                'asset/img/naver_logo.png',
              ),
              width: 60,
              height: 60,
            ),
          ),
        ]),
      ],
    );
  }

  void naverLogin() async {
    final NaverLoginResult user = await FlutterNaverLogin.logIn();
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    if (res.accessToken.isNotEmpty) {
      print('accessToken = ${res.accessToken}');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    }
  }
}
