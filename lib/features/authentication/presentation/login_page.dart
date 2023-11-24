import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/env.dart';

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

  Future<bool> _loginToDropbox() async {
    final prefs = await SharedPreferences.getInstance();
    String? credentials = prefs.getString(keyDBCredentials);
    if (credentials == null) {
      credentials = await Dropbox.getCredentials();
      prefs.setString(keyDBCredentials, credentials!);
    }

    String? testCredentials;
    //ignore: unnecessary_null_comparison
    if (credentials != null) {
      await Dropbox.authorizeWithCredentials(credentials);
      testCredentials = await Dropbox.getCredentials();
    }
    return testCredentials != null;
  }

  Future<void> _getAccountInfo() async {
    final result = await Dropbox.listFolder('/сделать');
    print(result);

    final name = await Dropbox.getAccountName();
    print('NAME: $name');

    final acc = await Dropbox.getCurrentAccount(forceCredentialsUse: true);
    print('ACC: ${acc?.name?.displayName} == ${acc?.profilePhotoUrl}');
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyDBCredentials);
    await Dropbox.unlink();
  }
}
