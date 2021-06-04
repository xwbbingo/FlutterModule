import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'package:start_app/demo/flutter_architecture/redux/app_state.dart';
import 'package:start_app/demo/flutter_architecture/redux/login/login_action.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageViewModel>(
      distinct: true,
      converter: (store) => LoginPageViewModel.fromStore(store, context),
      builder: (_, viewModel) => LoginPageContent(viewModel),
    );
  }
}

class LoginPageContent extends StatefulWidget {
  final LoginPageViewModel viewModel;

  LoginPageContent(this.viewModel);

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              _buildTitle(),
              _buildTitleLine(),
              SizedBox(height: 70.0),
              _buildNameTextField(),
              SizedBox(height: 30.0),
              _buildPasswordTextField(context),
              SizedBox(height: 60.0),
              _buildLoginButton(context),
            ],
          )),
          Offstage(
            offstage: !widget.viewModel.isLoading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black54,
              child: Center(
                child: SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '登录',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  Padding _buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  TextFormField _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Github帐号',
        suffixIcon: GestureDetector(
          onTap: () {
            _nameController.clear();
          },
          child: Icon(_nameController.text.length > 0 ? Icons.clear : null),
        ),
      ),
      maxLines: 1,
    );
  }

  TextFormField _buildPasswordTextField(BuildContext context) {
    return new TextFormField(
      controller: _passwordController,
      decoration: new InputDecoration(
        labelText: 'Github密码',
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      maxLines: 1,
      obscureText: _obscureText,
    );
  }

  Align _buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
          color: Colors.black,
          onPressed: _isValidLogin()
              ? () {
                  _login();
                }
              : null,
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  _isValidLogin() {
    String name = _nameController.text;
    String password = _passwordController.text;
    return name.length > 0 && password.length > 0;
  }

  _login() {
    String name = _nameController.text;
    String password = _passwordController.text;
    widget.viewModel.onLogin(name, password);
  }
}

typedef OnLogin = void Function(String name, String password);

class LoginPageViewModel {
  static final String TAG = "LoginPageViewModel";
  final OnLogin onLogin;
  final bool isLoading;

  LoginPageViewModel({this.onLogin, this.isLoading});

  static LoginPageViewModel fromStore(
      Store<AppState> store, BuildContext context) {
    return LoginPageViewModel(
        isLoading: store.state.loginState.isLoading,
        onLogin: (name, password) {
          LogUtil.v('name is $name, password is $password', tag: TAG);
          store.dispatch(FetchLoginAction(context, name, password));
        });
  }
}
