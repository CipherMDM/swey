import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.transparent,),onPressed: (){},)
        ],
        title: Center(child: Text("Admin Setup",style: TextStyle(color: Colors.black),),),
        
        
      ),
      body: Column(
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
              
            children: _controller.text.isEmpty?[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.wifi,color: Colors.orange,),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Wifi",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.wifi!=null?SettingsConfig.wifi:"",style: TextStyle(fontSize: 14),),
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
                          ),
                           ListTile(
                          leading: Icon(Icons.wifi_tethering,color: Colors.blueGrey,),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("HotSpot",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.hotspot!=null?SettingsConfig.hotspot:"",style: TextStyle(fontSize: 14),),
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
                          ),
                         ListTile(
                          leading: Icon(Icons.bluetooth,color: Colors.blueAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Bluetooth",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.bluetooth!=null?SettingsConfig.bluetooth:"",style: TextStyle(fontSize: 14),),
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
                          ),
                         ListTile(
                          leading: Icon(Icons.airplanemode_active,color: Colors.lightBlueAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Aeroplane mode",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.aeroplane_mode!=null?SettingsConfig.aeroplane_mode:"",style: TextStyle(fontSize: 14),),
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
                          ),
                          ListTile(
                          leading: Icon(Icons.data_usage,color: Colors.green),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Mobile Data",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.mobile_data!=null?SettingsConfig.mobile_data:"",style: TextStyle(fontSize: 14),),
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
                          ),
                          ListTile(
                          leading: Icon(Icons.music_note,color: Colors.indigoAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Sound",style: TextStyle(fontWeight: FontWeight.bold),),
                               Text(SettingsConfig.sound!=null?SettingsConfig.sound:"",style: TextStyle(fontSize: 12),),
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
                                              store.record("sound").add(db_handler.db, "Aloow");
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
                          ),
                          ListTile(
                          leading: Icon(Icons.camera_alt,color: Colors.pinkAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Camera",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(SettingsConfig.camera!=null?SettingsConfig.camera:"",style: TextStyle(fontSize: 12),),
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

                          ),
                            
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
                        ListTile(
                          leading: Icon(Icons.apps,color: Colors.deepPurple,),
                          title: Text("Allow Apps",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                            var route = MaterialPageRoute(builder: (context)=>AppSetUp());
                            Navigator.push(context, route);
                          },
                          ),
                          double.parse(SystemConfig.version?.split(" ")[1].split(".")[0])>=6? ListTile(
                          leading: Icon(Icons.bookmark,color: Colors.blueAccent),
                          title: Text("Permissions",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                            var route = CupertinoPageRoute(builder: (context)=>PermissionsPage());
                            Navigator.push(context, route);
                          },
                          ):
                          ListTile(
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
                          ),
                         ListTile(
                          leading: Icon(Icons.lock,color: Colors.red),
                          title: Text("Kiosk Password",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          ),
                          
                            
                      ],
                    ),
                  ),
                )
                
       
            ]:[

            ],
            ),
          )
         
        ],
      ),
    );
  }
}