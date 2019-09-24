import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permissions_kiosk/permissions_kiosk.dart';
import 'package:sembast/sembast.dart';
import 'package:swey/DataBase/db.dart';
import 'package:swey/allapps.dart';
import 'package:swey/settings.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/systemconfig.dart';
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
           db_handler.store.record("appdraw").get(db_handler.db).then((st){
              SystemConfig.appdraw= st;
              print(SystemConfig.appdraw);
            }); 

           db_handler.store.record("Apps").get(db_handler.db).then((apps){
                SystemConfig.appNames=apps;
                for(int i=0;i<AllApps.apps.length;i++){
                  if(SystemConfig.appNames.contains(AllApps.apps[i].packageName)){
                    SystemConfig.apps.add(AllApps.apps[i]);
                  }

                }
             

           }).then((_)async{
            
             await methodChannel.invokeMethod("Activate",{"apps",SystemConfig.appNames});
           }); 
          }
   
     

    });

  }

  Image wallpaper = Image.asset("lib/assets/close-up-drop-of-water-free-wallpaper-2604929.jpg");
  
  @override
  void initState() {
    
    getApps().then((_){
         getdata();
         
    });
    super.initState();
    
    
    
  }

  @override
  void dispose(){
    super.dispose();
   

  }

  
  @override
  Widget build(BuildContext context) {
   SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
   
   
    return Scaffold(
        body: Builder(
          builder:(context)=> GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(     
              image: DecorationImage(
                image: wallpaper.image,
                fit: BoxFit.fill
                ) 
            ),

            child: GestureDetector(
              onTap: (){
                setState(() {
                  
                });
              },
              child: Padding(
                         padding: const EdgeInsets.only(top:18.0,bottom: 10,),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[

                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(top:0,bottom: 10),
                                 child: ListView(
                              
                                //  crossAxisCount: 4,
                             
                              children: List.generate(SystemConfig.apps.length, (i) {
                                return Container(
                                height: 100,
                                child: ListTile(
                                  onTap: (){
                                     DeviceApps.openApp(SystemConfig.apps[i].packageName);
                                  },
                                  title: Text( SystemConfig.apps[i].appNmae,style: TextStyle(color: Colors.white.withOpacity(0.9)),),
                                  leading:(SystemConfig.apps[i].appIcon) ,
                                ),
                                
                              );
                               }),
                           )

                               
                               ),
                             ),
                           
                     Padding(
                      padding: const EdgeInsets.only(top:8.0,left: 10,right: 10),
                      child:Container(
                          height: 40,
                       child: ListTile(
                         trailing: IconButton(icon: Icon(Icons.settings,color: Colors.white.withOpacity(0.8)),
                          onPressed: (){
                              var route = CupertinoPageRoute(builder: (context)=>Settings());
                              Navigator.push(context, route);
                          },
                         ),
                         title: Container(
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white),
                           child: TextField(
                            
                            onChanged: (text){
                                  setState(() {
                                    
                                    
                                  });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top:16,bottom: 8,right: 10,left: 14),
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)
                              )
                            ),
                      ),
                         ),
                       ),
                    ),
                ),
                Padding(padding: EdgeInsets.all(10),)
                              
                           ],
                         ),
                      
                 ),
            ),
          
            
          ),
      ),
        ),

    );
  }
}




