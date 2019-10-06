import 'systemconfig.dart';

class AllApps {
  static List<Apps> apps = [];
  static Map<String, String> settings = {};

  AllApps.form(List<Apps> apps, Map<String, String> settings) {
    AllApps.apps = apps;
    AllApps.settings = settings;
  }
}
