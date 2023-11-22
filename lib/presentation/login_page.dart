import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dropbox_client/account_info.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/env.dart';

const String dropboxClientId = 'dash-todo-dropbox';
const String keyDBCredentials = 'DBCredentials';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    _initDropbox();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                onPressed: () async => _loginToDropboxPKCE(),
                child: const Text('login PKCE'),
              ),
              FilledButton(
                onPressed: () async => _loginToDropbox(),
                child: const Text('login '),
              ),
              FilledButton(
                onPressed: () async => _getAccountInfo(),
                child: const Text('Files '),
              ),
              FilledButton(
                onPressed: () async => _logout(),
                child: const Text('Logout '),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initDropbox() async {
    await Dropbox.init(
      dropboxClientId,
      Env.dropboxAppKey,
      Env.dropboxSecret,
    );
  }

  Future<void> _loginToDropboxPKCE() async {
    await Dropbox.authorizePKCE();
  }

  Future<void> _loginToDropbox() async {
    final prefs = await SharedPreferences.getInstance();
    String? credentials = prefs.getString(keyDBCredentials);
    print('CREDS PREFS: $credentials');
    // credentials = null;
    if (credentials == null) {
      credentials = await Dropbox.getCredentials();
      print('CREDS1111 : $credentials');
      prefs.setString(keyDBCredentials, credentials!);
    }

    // final credentials1111 = await Dropbox.getCredentials();
    // print('CREDS1111 : $credentials1111');

    print('CREDS1 : $credentials');

    if (credentials != null) {
      print('AUTH');
      await Dropbox.authorizeWithCredentials(credentials);
      final credentials2 = await Dropbox.getCredentials();
      print('CREDS2: $credentials2');
    }
  }

  Future<void> _getAccountInfo() async {
    final result = await Dropbox.listFolder('');
    print(result);

    final name = await Dropbox.getAccountName();
    print('NAME: $name');
    final accessToken =
        'sl.BqXuQ0-y9FDNBbSDtDBK4if6yy5x6tv28wPfDcpyORX3rP-5HtnG2BZP2Mw0hdmb_gD_Qn-y1AAFhrWNEztAXiEdAcAQBdW4gMlogMKUGIZQTTH1Lvk4-h6sUZKRAIJY0dHL68w9VKhW';
    var url =
        Uri.parse('https://api.dropboxapi.com/2/users/get_current_account');
    var response =
        await http.post(url, headers: {'Authorization': 'Bearer $accessToken'});
    print(response.body);
    final acc = AccountInfo.fromMap(jsonDecode(response.body));
    // print('ACC: $acc -- ${acc.email}');
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyDBCredentials);
    await Dropbox.unlink();
  }
}
