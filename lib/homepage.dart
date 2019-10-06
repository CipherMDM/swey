import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:sembast/sembast.dart';
import 'package:swey/DataBase/db.dart';
import 'package:swey/allapps.dart';
import 'package:swey/settings.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/setup/permissionspage.dart';
import 'package:swey/systemconfig.dart';
import 'DataBase/AppDatabase.dart';
import 'setUp.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const methodChannel = const MethodChannel("com.Cipher");
  TextEditingController _controller = TextEditingController();
  bool loaded = false;

  setupdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Quick Start"),
            children: <Widget>[
              ListTile(
                title: Text("Import from Cloud"),
                leading: Icon(
                  Icons.cloud,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
              ),
              ListTile(
                title: Text("Scan Qr code"),
                leading: Image.asset(
                  "lib/assets/iconfinder_qrcode_1608801.png",
                  height: 25,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
              ),
              ListTile(
                title: Text("Manual set up"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SetUp()));
                },
              )
            ],
          );
        });
  }

  Future<List> _getApps() async {
    List apps = await LauncherAssist.getAllApps();
    return apps;
  }

  Future getApps() async {
    db_handler.db = await AppDatabase.instance.database;
    db_handler.store = StoreRef.main();
    db_handler.make();

    _getApps().then((apps) {
      List<Apps> __apps = [];

      for (int i = 0; i < apps.length; i++) {
        db_handler.store.record("Apps").get(db_handler.db).then((allowapps) {
          if (allowapps.contains(apps[i]["label"])) {
            SystemConfig.appNames.add(apps[i]["package"]);
            SystemConfig.apps.add(Apps(
                appIcon: Image.memory(apps[i]["icon"]),
                appNmae: apps[i]["label"],
                packageName: apps[i]["package"]));
          }
        });

        __apps.add(Apps(
            appIcon: Image.memory(apps[i]["icon"]),
            appNmae: apps[i]["label"],
            packageName: apps[i]["package"]));
      }

      AllApps.form(__apps, null);
    });
  }

  getdata() async {
    db_handler.store.record("SetUp").exists(db_handler.db).then((bool isexit) {
      if (!isexit) {
        SystemConfig.isexist = false;
      } else {
        SystemConfig.isexist = true;
        db_handler.store.record("wifi").get(db_handler.db).then((st) {
          SettingsConfig.wifi = st == null ? "user" : st;
        });
        //  db_handler.store.record("hotSpot").get(db_handler.db).then((st){
        //     SettingsConfig.hotspot= st;
        //   });
        db_handler.store.record("bluetooth").get(db_handler.db).then((st) {
          SettingsConfig.bluetooth = st == null ? "user" : st;
        });
        db_handler.store.record("aeroplane").get(db_handler.db).then((st) {
          SettingsConfig.aeroplane_mode = st == null ? "user" : st;
        });
        db_handler.store.record("mobile").get(db_handler.db).then((st) {
          SettingsConfig.mobile_data = st == null ? "user" : st;
        });
        db_handler.store.record("sound").get(db_handler.db).then((st) {
          SettingsConfig.sound = st == null ? "Allow" : st;
        });
        db_handler.store.record("notify").get(db_handler.db).then((st) {
          SettingsConfig.notification_panel = st == null ? "Allow" : st;
        });
        //  db_handler.store.record("camera").get(db_handler.db).then((st){
        //     SettingsConfig.camera= st;
        //   });
        db_handler.store.record("Display").get(db_handler.db).then((st) {
          SettingsConfig.display = st == null ? "Allow" : st;
        });

        db_handler.store.record("Password").get(db_handler.db).then((st) {
          SystemConfig.password = st;
        });

        db_handler.store.record("Apps").get(db_handler.db).then((apps) {
          SystemConfig.appNames = apps;

          for (int i = 0; i < AllApps.apps?.length; i++) {
            if (SystemConfig.appNames.contains(AllApps.apps[i].packageName)) {
              SystemConfig.apps.add(AllApps.apps[i]);
            }
          }
        });
      }
    });
  }

  Image wallpaper = Image.asset(
      "lib/assets/close-up-drop-of-water-free-wallpaper-2604929.jpg");

  @override
  void initState() {
    getApps().then((_) {
      getdata();
    });
    Timer(Duration(seconds: 4), () {
      setState(() {
        loaded = true;
        methodChannel.invokeMethod("LoadApps", {
          "Apps": SystemConfig.appNames != null
              ? SystemConfig.appNames +
                  [
                    "com.Cipher.swey",
                    "com.android.systemui",
                    "com.android.incallui",
                    "android"
                  ]
              : [
                  "android",
                  "com.android.incallui",
                  "com.Cipher.swey",
                  "com.android.systemui"
                ],
          "Notify": SettingsConfig.notification_panel
        });
        if (SystemConfig.isexist) {
          methodChannel.invokeMethod("Activate");
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: wallpaper.image, fit: BoxFit.fill)),
          ),
          !loaded
              ? SplashScreen()
              : (!SystemConfig.isexist)
                  ? PermissionsPage(back: true)
                  : Builder(
                      builder: (context) {
                        if (SystemConfig.isexist) {
                          methodChannel.invokeMethod("Activate");
                        }

                        return GestureDetector(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 18.0,
                                  bottom: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 10),
                                          child: GridView.count(
                                              physics: BouncingScrollPhysics(),
                                              crossAxisCount: 4,
                                              children: _controller.text.isEmpty
                                                  ? List.generate(
                                                      SystemConfig.apps.length,
                                                      (i) {
                                                      return Container(
                                                          height: 100,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              LauncherAssist
                                                                  .launchApp(
                                                                      SystemConfig
                                                                          .apps[
                                                                              i]
                                                                          .packageName);
                                                            },
                                                            child: Center(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 55,
                                                                  child: SystemConfig
                                                                      .apps[i]
                                                                      .appIcon,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                        SystemConfig.apps[i].appNmae.toString().length > 8
                                                                            ? SystemConfig.apps[i].appNmae.toString().substring(0, 8) +
                                                                                ".."
                                                                            : SystemConfig.apps
                                                                                .where((apps) => apps.appNmae.toLowerCase().startsWith(_controller.text
                                                                                    .toLowerCase()))
                                                                                .toList()[
                                                                                    i]
                                                                                .appNmae
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white.withOpacity(0.8),
                                                                            fontSize: 12)))
                                                              ],
                                                            )),
                                                          ));
                                                    })
                                                  : List.generate(
                                                      SystemConfig.apps
                                                          .where((apps) => apps
                                                              .appNmae
                                                              .toLowerCase()
                                                              .startsWith(
                                                                  _controller
                                                                      .text
                                                                      .toLowerCase()))
                                                          .toList()
                                                          .length, (i) {
                                                      return Container(
                                                          height: 100,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              LauncherAssist.launchApp(SystemConfig
                                                                  .apps
                                                                  .where((apps) => apps
                                                                      .appNmae
                                                                      .toLowerCase()
                                                                      .startsWith(_controller
                                                                          .text
                                                                          .toLowerCase()))
                                                                  .toList()[i]
                                                                  .packageName);
                                                            },
                                                            child: Center(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 55,
                                                                  child: SystemConfig
                                                                      .apps
                                                                      .where((apps) => apps
                                                                          .appNmae
                                                                          .toLowerCase()
                                                                          .startsWith(_controller
                                                                              .text
                                                                              .toLowerCase()))
                                                                      .toList()[
                                                                          i]
                                                                      .appIcon,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                        SystemConfig.apps.where((apps) => apps.appNmae.toLowerCase().startsWith(_controller.text.toLowerCase())).toList()[i].appNmae.toString().length > 8
                                                                            ? SystemConfig.apps.where((apps) => apps.appNmae.toLowerCase().startsWith(_controller.text.toLowerCase())).toList()[i].appNmae.toString().substring(0, 8) +
                                                                                ".."
                                                                            : SystemConfig.apps
                                                                                .where((apps) => apps.appNmae.toLowerCase().startsWith(_controller.text
                                                                                    .toLowerCase()))
                                                                                .toList()[
                                                                                    i]
                                                                                .appNmae
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white.withOpacity(0.8),
                                                                            fontSize: 12)))
                                                              ],
                                                            )),
                                                          ));
                                                    }))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10, right: 10),
                                      child: Container(
                                        height: 40,
                                        child: ListTile(
                                          trailing: IconButton(
                                            icon: Icon(Icons.settings,
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                            onPressed: () {
                                              var route = CupertinoPageRoute(
                                                  builder: (context) =>
                                                      Settings());
                                              Navigator.push(context, route);
                                            },
                                          ),
                                          title: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: Colors.white),
                                            child: TextField(
                                              controller: _controller,
                                              onChanged: (text) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 16,
                                                          bottom: 8,
                                                          right: 10,
                                                          left: 14),
                                                  prefixIcon:
                                                      Icon(Icons.search),
                                                  hintText: "Search",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: ListTile(
          title: Center(
            child: ListTile(
              title: Center(
                child: RichText(
                  text: TextSpan(
                      text: "Swey",
                      style: TextStyle(
                          fontSize: 30, color: Colors.white.withOpacity(0.5))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
