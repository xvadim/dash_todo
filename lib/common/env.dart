import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'DROPBOX_APP_KEY', obfuscate: true)
  static final String dropboxAppKey = _Env.dropboxAppKey;

  @EnviedField(varName: 'DROPBOX_SECRET', obfuscate: true)
  static final String dropboxSecret = _Env.dropboxSecret;
}
