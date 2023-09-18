import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:upcloth/constant/color.dart';
import 'package:upcloth/screen/main_screen.dart';

class LoginScreenCustomer extends StatelessWidget {
  const LoginScreenCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Header(),
              _IdPwd(),
              _loginButton(),
              _convenient_login(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
        ),
        Icon(
          Icons.recycling,
          size: 100,
          color: GREEN_COLOR,
        ),
        Text(
          'UPCloth',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
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
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
                style: TextStyle(
                    color: Color(0xFF858585), fontWeight: FontWeight.bold),
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF3F3F3),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      borderSide: BorderSide(color: Colors.transparent)),
                  hintText: '아이디',
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextField(
                style: TextStyle(
                    color: Color(0xFF858585), fontWeight: FontWeight.bold),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF3F3F3),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      borderSide: BorderSide(color: Colors.transparent)),
                  hintText: '패스워드',
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xFF1EA43B),
                padding: EdgeInsets.all(8),
                shape: StadiumBorder()),
            onPressed: _login,
            child: const Text(
              '로그인',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: () {
                  print('아이디 찾기 클릭!!');
                },
                child: Text(
                  '아이디 찾기',
                  style: TextStyle(color: Color(0xFF8E8E8E)),
                )),
            Text(
              '|',
              style: TextStyle(color: Color(0xFF8E8E8E)),
            ),
            TextButton(
                onPressed: () {
                  print('비밀번호 찾기 클릭!!');
                },
                child: Text(
                  '비밀번호 찾기',
                  style: TextStyle(color: Color(0xFF8E8E8E)),
                )),
            Text(
              '|',
              style: TextStyle(color: Color(0xFF8E8E8E)),
            ),
            TextButton(
                onPressed: () {
                  print('회원가입 클릭!!');
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Color(0xFF8E8E8E)),
                )),
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
        SizedBox(
          height: 30,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: InkWell(
              onTap: naverLogin,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent), // 테두리 설정
                    borderRadius: BorderRadius.circular(8.0), // 사각형의 모서리 둥글게
                    image: DecorationImage(
                      image: const AssetImage('asset/img/naver_login.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('카카오톡 간편 로그인은 개발중입니다!')),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent), // 테두리 설정
                  borderRadius: BorderRadius.circular(8.0), // 사각형의 모서리 둥글게
                  image: DecorationImage(
                    image: const AssetImage('asset/img/kakao_login.png'),
                    fit: BoxFit.cover,
                  )),
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
