import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permissions_kiosk/permissions_kiosk.dart';
import 'package:sembast/sembast.dart';
import 'package:swey/DataBase/db.dart';
import 'package:swey/allapps.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/systemconfig.dart';
import 'appdrawer.dart';
import 'DataBase/AppDatabase.dart';
import 'setUp.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const methodChannel = const MethodChannel("com.Cipher");

 
  setupdialog(){
      showDialog(
         context: context,
         builder: (context){  
            return SimpleDialog(
               title: Text("Quick Start"),
               children: <Widget>[
                 
                     ListTile(
                       title: Text("Import from Cloud"),
                       leading: Icon(Icons.cloud,color: Colors.black,),
                       trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                     ),
                     ListTile(
                       title: Text("Scan Qr code"),
                       leading: Image.asset("lib/assets/iconfinder_qrcode_1608801.png",height: 25,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                     ),
                     ListTile(
                       title: Text("Manual set up"),
                       leading: Icon(Icons.settings,color: Colors.black,),
                       trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                       onTap: (){
                        
                         Navigator.push(context, CupertinoPageRoute(builder: (context)=>SetUp()));

                       },
                     )
                   
               ],
             );
         }
      );
  }

  Future<List> _getApps() async{
    List apps =  await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true,includeSystemApps: true,includeAppIcons: true);
    return apps;
  }


 Future getApps()async{
     db_handler.db = await AppDatabase.instance.database; 
     db_handler.store = StoreRef.main();
     db_handler.make();

    _getApps().then((apps){

      List<Apps> __apps = [];
          
      for(int i=0;i<apps.length;i++){
       
        db_handler.store.record("Apps").get(db_handler.db).then((allowapps){
          
           if(allowapps.contains(apps[i].packageName)){
            
             SystemConfig.appNames.add(apps[i].packageName);
             SystemConfig.apps.add(Apps(appIcon: Image.memory(apps[i].icon),appNmae: apps[i].appName,packageName: apps[i].packageName));
          }
        });
       
        __apps.add(Apps(appIcon: Image.memory(apps[i].icon),appNmae: apps[i].appName,packageName: apps[i].packageName));
        
      }

      PermissionsKiosk.platformVersion.then((data){
        SystemConfig.version=data;
        AllApps.form(__apps, null);
      });

       
      
      

    });

  }

  getdata() async {
   
   
   db_handler.store.record("SetUp").exists(db_handler.db).then((bool isexit){
  
           if(isexit){
              setupdialog();
          }else{
            
           db_handler.store.record("wifi").get(db_handler.db).then((st){
              SettingsConfig.wifi= st;
            });
           db_handler.store.record("hotSpot").get(db_handler.db).then((st){
              SettingsConfig.hotspot= st;
            });
           db_handler.store.record("bluetooth").get(db_handler.db).then((st){
              SettingsConfig.bluetooth= st;
            });
           db_handler.store.record("aeroplane").get(db_handler.db).then((st){
              SettingsConfig.aeroplane_mode= st;
            });
           db_handler.store.record("mobile").get(db_handler.db).then((st){
              SettingsConfig.mobile_data= st;
            });
           db_handler.store.record("sound").get(db_handler.db).then((st){
              SettingsConfig.sound= st;
            });
           db_handler.store.record("camera").get(db_handler.db).then((st){
              SettingsConfig.camera= st;
            });

           db_handler.store.record("Apps").get(db_handler.db).then((apps){
                SystemConfig.appNames=apps;
                for(int i=0;i<AllApps.apps.length;i++){
                  if(SystemConfig.appNames.contains(AllApps.apps[i].packageName)){
                    SystemConfig.apps.add(AllApps.apps[i]);
                  }

                }
             

           }).then((_)async{
             print("object");
             await methodChannel.invokeMethod("Activate",{"apps",SystemConfig.appNames});
           }); 
          }
   
     

    });

  }

  Image wallpaper = Image.asset("lib/assets/close-up-drop-of-water-free-wallpaper-2604929.jpg");
  
  @override
  void initState() {
    super.initState();
    getApps().then((_){
         getdata();
         
    });
    
    
  }

  @override
  void dispose(){
    super.dispose();
   

  }

  
  @override
  Widget build(BuildContext context) {
   SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
   
   
    return Scaffold(
      
      body: GestureDetector(
        onVerticalDragUpdate: (_){
          var route = MaterialPageRoute(builder: (context)=>AppDrawer());
          Navigator.push(context, route);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(     
            image: DecorationImage(
              image: wallpaper.image,
              fit: BoxFit.fill
              ) 
          ),

          child: Padding(
                     padding: const EdgeInsets.only(top:18.0,bottom: 10,left: 10,right: 10),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[

                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.only(top:18.0,bottom: 18),
                           
                           ),
                         ),
                         Icon(Icons.keyboard_arrow_up,color: Colors.white,),
                         
                          Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 90,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0.8),
                                      icon: Image.asset("lib/assets/iconfinder_phone_1645999.png",height: 45),
                                      onPressed: (){},
                                      )
                                   ),
                                  Container(
                                    height: 90,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0.8),
                                      icon: Image.asset("lib/assets/iconfinder_1041_boy_c_2400506.png"),
                                      onPressed: (){},)
                                   ),
                                    Container(
                                    height: 90,
                                    child: IconButton(
                                      padding: EdgeInsets.all(1.9),
                                      icon: Image.asset("lib/assets/iconfinder_browser_1646006.png",height: 100,),
                                      onPressed: (){},)
                                   ),
                                
                                   Container(
                                    height: 90,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0.8),
                                      icon: Image.asset("lib/assets/iconfinder_Email_2062072.png",height: 45),
                                      onPressed: (){},)
                                   ),
                                    Container(
                                    height: 90,
                                    child: IconButton(
                                      padding: EdgeInsets.all(1.9),
                                      icon: Image.asset("lib/assets/iconfinder_browser_1646006.png",height: 100,),
                                      onPressed: (){},)
                                   ),
                                     
                                ],
                                
                                
                              )
                            ),
                          
                       ],
                     ),
                  
             ),
        
          
        ),
      ),

    );
  }
}



