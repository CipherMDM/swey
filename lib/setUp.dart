import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permissions_kiosk/permissions_kiosk.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/setup/appsetup.dart';
import 'package:swey/setup/permissionspage.dart';
import 'package:swey/systemconfig.dart';
import 'package:sembast/sembast.dart';
import 'DataBase/db.dart';

class SetUp extends StatefulWidget {
  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  TextEditingController _controller = new TextEditingController();
  var store = StoreRef.main();

  

  @override
  void initState() {
   
    super.initState();

   
  }
  
  
  
  static const methodChannel = const MethodChannel("com.Cipher");

  @override
  Widget build(BuildContext context) {

    bool singlemode = false;
   
    return Scaffold(            
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings),title: Container()),
          BottomNavigationBarItem(icon: Image.asset("lib/assets/iconfinder_qrcode_1608801.png",height: 25,),title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.cloud),title: Container())
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.highlight_off,color: Colors.red,),onPressed: (){
             methodChannel.invokeMethod("Deactivate").then((_){
                methodChannel.invokeMethod("OpenSettings");
             });
             
          },)
        ],
        title: Center(child: Text("Admin Setup",style: TextStyle(color: Colors.black),),),
        
        
      ),
      body: Builder(
        builder:(context)=> Column(
          children: <Widget>[
             Padding(
                  padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                  child:Container(
                      height: 40,
                   child: TextField(
                    controller: _controller,
                    onChanged: (text){
                          setState(() {
                            
                          });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top:16,bottom: 8,right: 10,left: 14),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
               Expanded(
              child: ListView(
                
              children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: <Widget>[
                          (_controller.text.isEmpty || "wifi".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.wifi,color: Colors.orange,),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Wifi",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.wifi!=null?SettingsConfig.wifi:"",
                                 style: TextStyle(fontSize: 14,
                                   color: SettingsConfig.wifi=="user"?Colors.red:
                                          SettingsConfig.wifi=="off"?Colors.blue:
                                          SettingsConfig.wifi=="on"?Colors.green:Colors.transparent
                                 ),
                                    
                                 ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Wifi"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Always on"),
                                       onPressed: (){
                                         setState((){
                                           
                                           SettingsConfig.wifi="on";
                                            store.record("wifi").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("wifi").update(db_handler.db, "on");
                                             }else{
                                                store.record("wifi").add(db_handler.db, "on");
                                             }
                                             
                                             
                                           });
                                          
                                          
                                         });
                                         Navigator.of(context).pop();
                                       },
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Always off"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.wifi="off";
                                           store.record("wifi").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("wifi").update(db_handler.db, "off");
                                             }else{
                                                store.record("wifi").add(db_handler.db, "off");
                                             }
                                             
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.wifi="user";
                                           store.record("wifi").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("wifi").update(db_handler.db, "user");
                                             }else{
                                                store.record("wifi").add(db_handler.db, "user");
                                             }
                                           
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                     ),
                                  ],

                                )
                              );
                            },
                            ):Center(),
                            (_controller.text.isEmpty || "hotspot".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.wifi_tethering,color: Colors.blueGrey,),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("HotSpot",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.hotspot!=null?SettingsConfig.hotspot:"",style: TextStyle(fontSize: 14,
                                     color: SettingsConfig.hotspot=="user"?Colors.red:
                                          SettingsConfig.hotspot=="off"?Colors.blue:
                                          SettingsConfig.hotspot=="on"?Colors.green:Colors.transparent
                                 
                                 ),
                                    
                                 ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("HotSpot"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Always on"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.hotspot="on";
                                           store.record("hotSpot").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("hotSpot").update(db_handler.db, "on");
                                             }else{
                                                store.record("hotSpot").add(db_handler.db, "on");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Always off"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.hotspot="off";
                                           store.record("hotSpot").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("hotSpot").update(db_handler.db, "off");
                                             }else{
                                               store.record("hotSpot").add(db_handler.db, "off");
                                             }
                                             
                                           });
                                         });      
                                          Navigator.of(context).pop();
                                       },
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                          SettingsConfig.hotspot="user";
                                          store.record("hotSpot").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("hotSpot").update(db_handler.db, "user");
                                             }else{
                                                store.record("hotSpot").add(db_handler.db, "user");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                     ),
                                  ],

                                )
                              );
                            },
                            ):Center(),
                           (_controller.text.isEmpty || "bluetooth".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.bluetooth,color: Colors.blueAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Bluetooth",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.bluetooth!=null?SettingsConfig.bluetooth:"",style: TextStyle(fontSize: 14,
                                     color: SettingsConfig.bluetooth=="user"?Colors.red:
                                          SettingsConfig.bluetooth=="off"?Colors.blue:
                                          SettingsConfig.bluetooth=="on"?Colors.green:Colors.transparent
                                 
                                 ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Bluetooth"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Always on"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.bluetooth="on";
                                           store.record("bluetooth").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("bluetooth").update(db_handler.db, "on");
                                             }else{
                                                store.record("bluetooth").add(db_handler.db, "on");
                                             }
                                                                                         
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Always off"),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.bluetooth="off";
                                           store.record("bluetooth").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("bluetooth").update(db_handler.db, "off");
                                             }else{
                                                store.record("bluetooth").add(db_handler.db, "off");
                                             }
                                                                                          
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.bluetooth="user";
                                           store.record("bluetooth").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("bluetooth").update(db_handler.db, "user");
                                             }else{
                                                store.record("bluetooth").add(db_handler.db, "user");
                                             }
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                     ),
                                  ],

                                )
                              );
                            },
                            ):Center(),
                           (_controller.text.isEmpty || "aeroplane mode".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.airplanemode_active,color: Colors.lightBlueAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Aeroplane mode",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.aeroplane_mode!=null?SettingsConfig.aeroplane_mode:"",style: TextStyle(fontSize: 14,
                                  color: SettingsConfig.aeroplane_mode=="user"?Colors.red:
                                          SettingsConfig.aeroplane_mode=="off"?Colors.blue:
                                          SettingsConfig.aeroplane_mode=="on"?Colors.green:Colors.transparent
                                 
                                 ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Aeroplane mode"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Always on"),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.aeroplane_mode="on";
                                           store.record("aeroplane").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("aeroplane").update(db_handler.db, "on");
                                             }else{
                                                store.record("aeroplane").add(db_handler.db, "on");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                       },
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Always off"),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.aeroplane_mode="off";
                                           store.record("aeroplane").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("aeroplane").update(db_handler.db, "off");
                                             }else{
                                                store.record("aeroplane").add(db_handler.db, "off");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.aeroplane_mode="user";
                                           store.record("aeroplane").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("aeroplane").update(db_handler.db, "user");
                                             }else{
                                                store.record("aeroplane").add(db_handler.db, "user");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                  ],

                                )
                              );
                            },
                            ):Center(),
                            (_controller.text.isEmpty || "mobile data".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.data_usage,color: Colors.green),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Mobile Data",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.mobile_data!=null?SettingsConfig.mobile_data:"",style: TextStyle(fontSize: 14,
                                     color: SettingsConfig.mobile_data=="user"?Colors.red:
                                          SettingsConfig.mobile_data=="off"?Colors.blue:
                                          SettingsConfig.mobile_data=="on"?Colors.green:Colors.transparent
                                
                                 ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Mobile Data"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Always on"),
                                        onPressed: (){
                                         setState(() {
                                           SettingsConfig.mobile_data="on";
                                           store.record("mobile").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("mobile").update(db_handler.db, "on");
                                             }else{
                                                store.record("mobile").add(db_handler.db, "on");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Always off"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.mobile_data="off";
                                           store.record("mobile").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("mobile").update(db_handler.db, "off");
                                             }else{
                                                store.record("mobile").add(db_handler.db, "off");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.mobile_data="user";
                                           store.record("mobile").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("mobile").update(db_handler.db, "user");
                                             }else{
                                                store.record("mobile").add(db_handler.db, "user");
                                             }
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                  ],

                                )
                              );
                            },
                            ):Center(),
                           (_controller.text.isEmpty || "sound".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.music_note,color: Colors.indigoAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Sound",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.sound!=null?SettingsConfig.sound:"",style: TextStyle(fontSize: 13,

                                  color: SettingsConfig.sound=="Allow"?Colors.red:
                                          SettingsConfig.sound=="Deny"?Colors.blue:
                                          Colors.transparent
                                 
                                 
                                 ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Sound"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Deny"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.sound="Deny";
                                           store.record("sound").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("sound").update(db_handler.db, "Deny");
                                             }else{
                                                store.record("sound").add(db_handler.db, "Deny");
                                             }
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.sound="Allow";
                                            store.record("sound").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("sound").update(db_handler.db, "Allow");
                                             }else{
                                                store.record("sound").add(db_handler.db, "Allow");
                                             }
                                             
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),

                                  ],

                                )
                              );
                            },
                            ):Center(),

                            (_controller.text.isEmpty || "display".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.tv,color: Colors.orangeAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Display",style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(SettingsConfig.display!=null?SettingsConfig.display:"",style: TextStyle(fontSize: 13,
                                    color: SettingsConfig.display=="Allow"?Colors.red:
                                          SettingsConfig.display=="Deny"?Colors.blue:
                                          Colors.transparent
                                 ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Display"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Deny"),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.display="Deny";
                                           store.record("Display").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("Display").update(db_handler.db, "Deny");
                                             }else{
                                                store.record("Display").add(db_handler.db, "Deny");
                                             }
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                       
                                     ),
                                     CupertinoDialogAction(
                                       child: Text("Allow",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.display="Allow";
                                            store.record("Display").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("Display").update(db_handler.db, "Allow");
                                             }else{
                                                store.record("Display").add(db_handler.db, "Allow");
                                             }
                                             
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                     
                                  ],

                                )
                              );
                            },
                            ):Center(),
                            (_controller.text.isEmpty || "camera".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.camera_alt,color: Colors.pinkAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Camera",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(SettingsConfig.camera!=null?SettingsConfig.camera:"",style: TextStyle(fontSize: 13,
                                   color: SettingsConfig.camera=="Allow"?Colors.red:
                                          SettingsConfig.camera=="Deny"?Colors.blue:
                                          Colors.transparent
                                
                                ),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context)=>CupertinoAlertDialog(

                                  title: Text("Camera"),
                                  
                                 
                                  actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text("Deny"),
                                       onPressed: (){
                                         setState(() {
                                            SettingsConfig.camera="Deny";
                                             store.record("camera").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("camera").update(db_handler.db, "Deny");
                                             }else{
                                                store.record("camera").add(db_handler.db, "Deny");
                                             }
                                             
                                           });
                                         });
                                          Navigator.of(context).pop();
                                         }
                                       
                                     ),
                                    
                                     CupertinoDialogAction(
                                       child: Text("Allow",style: TextStyle(color: Colors.red),),
                                       onPressed: (){
                                         setState(() {
                                           SettingsConfig.camera="Allow";
                                           store.record("camera").exists(db_handler.db).then((exist){
                                             if(exist){
                                              store.record("camera").update(db_handler.db, "Allow");
                                             }else{
                                                store.record("camera").add(db_handler.db, "Allow");
                                             }
                                             
                                           });
                                           
                                         });
                                          Navigator.of(context).pop();
                                         }
                                     ),
                                  ],

                                )
                              );
                            },

                            ):Center(),
                              
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: <Widget>[
                         (_controller.text.isEmpty || "allow apps".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.apps,color: Colors.deepPurple,),
                            title: Text("Allow Apps",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              var route = MaterialPageRoute(builder: (context)=>AppSetUp());
                              Navigator.push(context, route);
                            },
                            ):Center(),

                           SystemConfig.appNames.length>1?Center():(_controller.text.isEmpty || "single app mode".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.touch_app,color: Colors.blue,),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Single App Mode",style: TextStyle(fontWeight: FontWeight.bold),),
                                Switch(onChanged: (_){
                                    if(SystemConfig.appNames.length==1){
                                      singlemode=true;
                                      
                                    }else{
                                      singlemode=false;
                                    }
                                    setState(() {
                                      
                                    });
                                }
                                ,value: singlemode,)
                              ],
                            ),
                         
                            onTap: (){
                              var route = MaterialPageRoute(builder: (context)=>AppSetUp());
                              Navigator.push(context, route);
                            },
                            ):Center(),
                            
                            ]
                            ))
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: <Widget>[
                         
                            
                            
                           double.parse(SystemConfig.version?.split(" ")[1].split(".")[0])>=6?(_controller.text.isEmpty || "permissions".startsWith(_controller.text.toLowerCase()))? ListTile(
                            leading: Icon(Icons.bookmark,color: Colors.blueAccent),
                            title: Text("Permissions",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              var route = CupertinoPageRoute(builder: (context)=>PermissionsPage());
                              Navigator.push(context, route);
                            },
                            ):Center():Center(),
                           
                           (_controller.text.isEmpty || "kiosk password".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.lock,color: Colors.red),
                            title: Text("Kiosk Password",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            ):Center(),
                            
                              
                        ],
                      ),
                    ),
                  ),
                   double.parse(SystemConfig.version?.split(" ")[1].split(".")[0])<6? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: <Widget>[
                           ListTile(
                              leading: Icon(Icons.home,color: Colors.orange),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                   Text("Default Launcher",style: TextStyle(fontWeight: FontWeight.bold),),
                                 
                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                              onTap: (){

                                       PermissionsKiosk.isUsageSettings().then((_){
                                          if(_){
                                              PermissionsKiosk.setLauncher();
                                          }else{
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                action: SnackBarAction(label: "Enable",onPressed: (){
                                                     PermissionsKiosk.getUsageSettings();  
                                                },),
                                                content:Row(
                                               
                                                children: <Widget>[
                                                   Padding(
                                                    padding: EdgeInsets.only(right: 10),
                                                    child:  Icon(Icons.trip_origin,color: Colors.orange,),
                                                  ),
                                                  Text("Enable Usage Access",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),)
                                                  
                                                ],),
                                                                                            
                                                ));

                                          }
                                        });
                                              
                              },
                              ),

                           (_controller.text.isEmpty || "disable usb bebugging".startsWith(_controller.text.toLowerCase()))? ListTile(
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            leading: Icon(Icons.usb,color: Colors.red,),
                            
                            title:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Disable Usb Debugging",style: TextStyle(fontWeight: FontWeight.bold),),
                               
                              ],
                            ),
                            onTap: (){
                                methodChannel.invokeMethod("OpenDev");
                            },
                            ):Center(),    

                          (_controller.text.isEmpty || "enable usage access".startsWith(_controller.text.toLowerCase()))?ListTile(
                            leading: Icon(Icons.access_time,color: Colors.lightBlueAccent),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Enable Usage Access",style: TextStyle(fontWeight: FontWeight.bold),),
                                                           
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                            onTap: (){
                              
                                     PermissionsKiosk.getUsageSettings(); 
                                     
                             
                            },
                            ):Center()
                         
                            
                              
                        ],
                      ),
                    ),
                  ):Center()
                  
         
              ]
              ),
            )
           
          ],
        ),
      ),
    );
  }
}


