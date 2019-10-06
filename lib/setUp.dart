import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/setup/appsetup.dart';
import 'package:swey/systemconfig.dart';
import 'package:sembast/sembast.dart';
import 'DataBase/db.dart';

class SetUp extends StatefulWidget {
  bool back;
  SetUp({this.back});
  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  

  @override
  void initState() {
    super.initState();
  }

  static const methodChannel = const MethodChannel("com.Cipher");
   List<Widget> setup = [NormalSetUp(),QrCodeSetUp(),CloudeSetup()];
   var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
     
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 0,
        unselectedItemColor: Colors.black.withOpacity(0.8),
        backgroundColor: Colors.white,
        onTap: (_){
            currentIndex=_;
            setState(() {
              
            });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.qrcode), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), title: Container())
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: widget.back == null
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Center(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
              color: Colors.red,
            ),
            onPressed: () {
              methodChannel.invokeMethod("Deactivate");
            },
          )
        ],
        title: Center(
          child: Text(
            "Kiosk Setup",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body:setup[currentIndex] 
    );
  }
}


class NormalSetUp extends StatefulWidget {
  @override
  _NormalSetUpState createState() => _NormalSetUpState();
}

class _NormalSetUpState extends State<NormalSetUp> {
  TextEditingController _controller = new TextEditingController();
  var store = StoreRef.main();
  bool singlemode = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
              child: Container(
                height: 40,
                child: TextField(
                  controller: _controller,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 16, bottom: 8, right: 10, left: 14),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Expanded(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: <Widget>[
                        (_controller.text.isEmpty ||
                                "wifi"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading: Icon(
                                  Icons.wifi,
                                  color: Colors.orange,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Wifi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.wifi != null
                                          ? SettingsConfig.wifi
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: SettingsConfig.wifi == "user"
                                              ? Colors.red
                                              : SettingsConfig.wifi == "off"
                                                  ? Colors.blue
                                                  : SettingsConfig.wifi == "on"
                                                      ? Colors.green
                                                      : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Wifi"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text("Always on"),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.wifi = "on";
                                                    store
                                                        .record("wifi")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("wifi")
                                                            .update(
                                                                db_handler.db,
                                                                "on");
                                                      } else {
                                                        store
                                                            .record("wifi")
                                                            .add(db_handler.db,
                                                                "on");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text("Always off"),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.wifi = "off";
                                                    store
                                                        .record("wifi")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("wifi")
                                                            .update(
                                                                db_handler.db,
                                                                "off");
                                                      } else {
                                                        store
                                                            .record("wifi")
                                                            .add(db_handler.db,
                                                                "off");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text(
                                                  "Allow user",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.wifi =
                                                        "user";
                                                    store
                                                        .record("wifi")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("wifi")
                                                            .update(
                                                                db_handler.db,
                                                                "user");
                                                      } else {
                                                        store
                                                            .record("wifi")
                                                            .add(db_handler.db,
                                                                "user");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ));
                                },
                              )
                            : Center(),
                        // (_controller.text.isEmpty || "hotspot".startsWith(_controller.text.toLowerCase()))? ListTile(
                        // leading: Icon(Icons.wifi_tethering,color: Colors.blueGrey,),
                        // title: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Text("HotSpot",style: TextStyle(fontWeight: FontWeight.bold),),
                        //      Text(SettingsConfig.hotspot!=null?SettingsConfig.hotspot:"",style: TextStyle(fontSize: 14,
                        //          color: SettingsConfig.hotspot=="user"?Colors.red:
                        //               SettingsConfig.hotspot=="off"?Colors.blue:
                        //               SettingsConfig.hotspot=="on"?Colors.green:Colors.transparent

                        //      ),

                        //      ),
                        //   ],
                        // ),
                        // trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                        // onTap: (){
                        //   showDialog(
                        //     context: context,
                        //     builder: (context)=>CupertinoAlertDialog(

                        //       title: Text("HotSpot"),

                        //       actions: <Widget>[
                        //          CupertinoDialogAction(
                        //            child: Text("Always on"),
                        //            onPressed: (){
                        //              setState(() {
                        //                SettingsConfig.hotspot="on";
                        //                store.record("hotSpot").exists(db_handler.db).then((exist){
                        //                  if(exist){
                        //                   store.record("hotSpot").update(db_handler.db, "on");
                        //                  }else{
                        //                     store.record("hotSpot").add(db_handler.db, "on");
                        //                  }

                        //                });
                        //              });
                        //               Navigator.of(context).pop();
                        //            },

                        //          ),
                        //          CupertinoDialogAction(
                        //            child: Text("Always off"),
                        //            onPressed: (){
                        //              setState(() {
                        //                SettingsConfig.hotspot="off";
                        //                store.record("hotSpot").exists(db_handler.db).then((exist){
                        //                  if(exist){
                        //                   store.record("hotSpot").update(db_handler.db, "off");
                        //                  }else{
                        //                    store.record("hotSpot").add(db_handler.db, "off");
                        //                  }

                        //                });
                        //              });
                        //               Navigator.of(context).pop();
                        //            },
                        //          ),
                        //          CupertinoDialogAction(
                        //            child: Text("Allow user",style: TextStyle(color: Colors.red),),
                        //            onPressed: (){
                        //              setState(() {
                        //               SettingsConfig.hotspot="user";
                        //               store.record("hotSpot").exists(db_handler.db).then((exist){
                        //                  if(exist){
                        //                   store.record("hotSpot").update(db_handler.db, "user");
                        //                  }else{
                        //                     store.record("hotSpot").add(db_handler.db, "user");
                        //                  }

                        //                });
                        //              });
                        //               Navigator.of(context).pop();
                        //            },
                        //          ),
                        //       ],

                        //     )
                        //   );
                        // },
                        // ):Center(),
                        (_controller.text.isEmpty ||
                                "bluetooth"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading: Icon(Icons.bluetooth,
                                    color: Colors.blueAccent),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Bluetooth",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.bluetooth != null
                                          ? SettingsConfig.bluetooth
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: SettingsConfig.bluetooth ==
                                                  "user"
                                              ? Colors.red
                                              : SettingsConfig.bluetooth ==
                                                      "off"
                                                  ? Colors.blue
                                                  : SettingsConfig.bluetooth ==
                                                          "on"
                                                      ? Colors.green
                                                      : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Bluetooth"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text("Always on"),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.bluetooth =
                                                        "on";
                                                    store
                                                        .record("bluetooth")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("bluetooth")
                                                            .update(
                                                                db_handler.db,
                                                                "on");
                                                      } else {
                                                        store
                                                            .record("bluetooth")
                                                            .add(db_handler.db,
                                                                "on");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text("Always off"),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.bluetooth =
                                                        "off";
                                                    store
                                                        .record("bluetooth")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("bluetooth")
                                                            .update(
                                                                db_handler.db,
                                                                "off");
                                                      } else {
                                                        store
                                                            .record("bluetooth")
                                                            .add(db_handler.db,
                                                                "off");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text(
                                                  "Allow user",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig.bluetooth =
                                                        "user";
                                                    store
                                                        .record("bluetooth")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("bluetooth")
                                                            .update(
                                                                db_handler.db,
                                                                "user");
                                                      } else {
                                                        store
                                                            .record("bluetooth")
                                                            .add(db_handler.db,
                                                                "user");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ));
                                },
                              )
                            : Center(),
                        (_controller.text.isEmpty ||
                                "aeroplane mode"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading: Icon(Icons.airplanemode_active,
                                    color: Colors.lightBlueAccent),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Aeroplane mode",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.aeroplane_mode != null
                                          ? SettingsConfig.aeroplane_mode
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: SettingsConfig
                                                      .aeroplane_mode ==
                                                  "user"
                                              ? Colors.red
                                              : SettingsConfig.aeroplane_mode ==
                                                      "off"
                                                  ? Colors.blue
                                                  : SettingsConfig
                                                              .aeroplane_mode ==
                                                          "on"
                                                      ? Colors.green
                                                      : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Aeroplane mode"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text("Always on"),
                                                onPressed: () {
                                                  setState(() {
                                                    SettingsConfig
                                                        .aeroplane_mode = "on";
                                                    store
                                                        .record("aeroplane")
                                                        .exists(db_handler.db)
                                                        .then((exist) {
                                                      if (exist) {
                                                        store
                                                            .record("aeroplane")
                                                            .update(
                                                                db_handler.db,
                                                                "on");
                                                      } else {
                                                        store
                                                            .record("aeroplane")
                                                            .add(db_handler.db,
                                                                "on");
                                                      }
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text("Always off"),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig
                                                              .aeroplane_mode =
                                                          "off";
                                                      store
                                                          .record("aeroplane")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record(
                                                                  "aeroplane")
                                                              .update(
                                                                  db_handler.db,
                                                                  "off");
                                                        } else {
                                                          store
                                                              .record(
                                                                  "aeroplane")
                                                              .add(
                                                                  db_handler.db,
                                                                  "off");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    "Allow user",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig
                                                              .aeroplane_mode =
                                                          "user";
                                                      store
                                                          .record("aeroplane")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record(
                                                                  "aeroplane")
                                                              .update(
                                                                  db_handler.db,
                                                                  "user");
                                                        } else {
                                                          store
                                                              .record(
                                                                  "aeroplane")
                                                              .add(
                                                                  db_handler.db,
                                                                  "user");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ));
                                },
                              )
                            : Center(),
                        (_controller.text.isEmpty ||
                                "mobile data"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading:
                                    Icon(Icons.data_usage, color: Colors.green),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Mobile Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.mobile_data != null
                                          ? SettingsConfig.mobile_data
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: SettingsConfig.mobile_data ==
                                                  "user"
                                              ? Colors.red
                                              : SettingsConfig.mobile_data ==
                                                      "off"
                                                  ? Colors.blue
                                                  : SettingsConfig
                                                              .mobile_data ==
                                                          "on"
                                                      ? Colors.green
                                                      : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Mobile Data"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                  child: Text("Always on"),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig
                                                          .mobile_data = "on";
                                                      store
                                                          .record("mobile")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("mobile")
                                                              .update(
                                                                  db_handler.db,
                                                                  "on");
                                                        } else {
                                                          store
                                                              .record("mobile")
                                                              .add(
                                                                  db_handler.db,
                                                                  "on");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text("Always off"),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig
                                                          .mobile_data = "off";
                                                      store
                                                          .record("mobile")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("mobile")
                                                              .update(
                                                                  db_handler.db,
                                                                  "off");
                                                        } else {
                                                          store
                                                              .record("mobile")
                                                              .add(
                                                                  db_handler.db,
                                                                  "off");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    "Allow user",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig
                                                          .mobile_data = "user";
                                                      store
                                                          .record("mobile")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("mobile")
                                                              .update(
                                                                  db_handler.db,
                                                                  "user");
                                                        } else {
                                                          store
                                                              .record("mobile")
                                                              .add(
                                                                  db_handler.db,
                                                                  "user");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ));
                                },
                              )
                            : Center(),
                        (_controller.text.isEmpty ||
                                "sound"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading: Icon(Icons.music_note,
                                    color: Colors.indigoAccent),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Sound",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.sound != null
                                          ? SettingsConfig.sound
                                          : "",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: SettingsConfig.sound == "Allow"
                                              ? Colors.red
                                              : SettingsConfig.sound == "Deny"
                                                  ? Colors.blue
                                                  : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Sound"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                  child: Text("Deny"),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig.sound =
                                                          "Deny";
                                                      store
                                                          .record("sound")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("sound")
                                                              .update(
                                                                  db_handler.db,
                                                                  "Deny");
                                                        } else {
                                                          store
                                                              .record("sound")
                                                              .add(
                                                                  db_handler.db,
                                                                  "Deny");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    "Allow",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig.sound =
                                                          "Allow";
                                                      store
                                                          .record("sound")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("sound")
                                                              .update(
                                                                  db_handler.db,
                                                                  "Allow");
                                                        } else {
                                                          store
                                                              .record("sound")
                                                              .add(
                                                                  db_handler.db,
                                                                  "Allow");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ));
                                },
                              )
                            : Center(),

                        (_controller.text.isEmpty ||
                                "display"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading:
                                    Icon(Icons.tv, color: Colors.orangeAccent),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Display",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      SettingsConfig.display != null
                                          ? SettingsConfig.display
                                          : "",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: SettingsConfig.display ==
                                                  "Allow"
                                              ? Colors.red
                                              : SettingsConfig.display == "Deny"
                                                  ? Colors.blue
                                                  : Colors.transparent),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("Display"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                  child: Text("Deny"),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig.display =
                                                          "Deny";
                                                      store
                                                          .record("Display")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("Display")
                                                              .update(
                                                                  db_handler.db,
                                                                  "Deny");
                                                        } else {
                                                          store
                                                              .record("Display")
                                                              .add(
                                                                  db_handler.db,
                                                                  "Deny");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text(
                                                    "Allow",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      SettingsConfig.display =
                                                          "Allow";
                                                      store
                                                          .record("Display")
                                                          .exists(db_handler.db)
                                                          .then((exist) {
                                                        if (exist) {
                                                          store
                                                              .record("Display")
                                                              .update(
                                                                  db_handler.db,
                                                                  "Allow");
                                                        } else {
                                                          store
                                                              .record("Display")
                                                              .add(
                                                                  db_handler.db,
                                                                  "Allow");
                                                        }
                                                      });
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ));
                                },
                              )
                            : Center(),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(children: <Widget>[
                          (_controller.text.isEmpty ||
                                  "allow apps".startsWith(
                                      _controller.text.toLowerCase()))
                              ? ListTile(
                                  leading: Icon(
                                    Icons.apps,
                                    color: Colors.deepPurple,
                                  ),
                                  title: Text(
                                    "Allow Apps",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  onTap: () {
                                    var route = MaterialPageRoute(
                                        builder: (context) => AppSetUp());
                                    Navigator.push(context, route);
                                  },
                                )
                              : Center(),
                          SystemConfig.appNames.length > 1
                              ? Center()
                              : (_controller.text.isEmpty ||
                                      "single app mode".startsWith(
                                          _controller.text.toLowerCase()))
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.touch_app,
                                        color: Colors.blue,
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Single App Mode",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Switch(
                                            onChanged: (_) {
                                              if (singlemode) {
                                                singlemode = false;
                                              } else {
                                                singlemode = true;
                                              }
                                            },
                                            value: singlemode,
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        var route = MaterialPageRoute(
                                            builder: (context) => AppSetUp());
                                        Navigator.push(context, route);
                                      },
                                    )
                                  : Center(),
                        ]))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: <Widget>[
                        (_controller.text.isEmpty ||
                                "kiosk password"
                                    .startsWith(_controller.text.toLowerCase()))
                            ? ListTile(
                                leading: Icon(Icons.lock, color: Colors.red),
                                onTap: () {
                                  showDialog(
                                      builder: (cont) {
                                        TextEditingController _controller =
                                            new TextEditingController();
                                        return CupertinoAlertDialog(
                                          title: Text("Kiosk Password"),
                                          content: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, top: 18),
                                            child: Container(
                                              height: 40,
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: TextField(
                                                  controller: _controller,
                                                  decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.lock,
                                                        size: 20,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 9,
                                                              bottom: 8,
                                                              left: 18),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text(
                                                "Exit",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Navigator.of(cont).pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text("Save"),
                                              onPressed: () {
                                                if (_controller.text.length <
                                                    4) {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons.trip_origin,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Required Atleast 4 character",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                } else {
                                                  db_handler.store
                                                      .record("Password")
                                                      .add(
                                                          db_handler.db,
                                                          _controller.text
                                                              .toString())
                                                      .then((_) {
                                                    SystemConfig.password =
                                                        _controller.text;
                                                  });
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Icon(
                                                            Icons.trip_origin,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Password Saved Sucessfuly",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                  Navigator.pop(cont);
                                                }
                                              },
                                            )
                                          ],
                                        );
                                      },
                                      context: context);
                                },
                                title: Text(
                                  "Kiosk Password",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              )
                            : Center(),
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      );
  }
}


class CloudeSetup extends StatefulWidget {
  @override
  _CloudeSetupState createState() => _CloudeSetupState();
}

class _CloudeSetupState extends State<CloudeSetup> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(child: Text("Cloud Setup"),),
      
    );
  }
}


class QrCodeSetUp extends StatefulWidget {
  @override
  _QrCodeSetUpState createState() => _QrCodeSetUpState();
}

class _QrCodeSetUpState extends State<QrCodeSetUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text("Qr Setup"),),
    );
  }
}