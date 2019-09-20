import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:swey/allapps.dart';
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

  var store = StoreRef.main();
  Database db; 
  

 
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

    _getApps().then((apps){

      List<Apps> _apps = [];
      List<Apps> __apps = [];
      List<String> appName=[]; 
     
      for(int i=0;i<apps.length;i++){
       
        __apps.add(Apps(appIcon: Image.memory(apps[i].icon),appNmae: apps[i].appName,packageName: apps[i].packageName));
        
      }
      SystemConfig.form(_apps, appName ,null);
      AllApps.form(__apps, null);
      
      

    });

  }

  getdata() async {
    db = await AppDatabase.instance.database; 
    store.record("SetUp").exists(db).then((bool isexit){

      if(!isexit){
         setupdialog();
      }

    });

  }

  // Image wallpaper = Image.network("");
  
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
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(     
          // image: DecorationImage(
          //   image: wallpaper.image,
          //   fit: BoxFit.fill
          //   ) 
        ),

        child: Padding(
                   padding: const EdgeInsets.only(top:18.0,bottom: 18,left: 12,right: 12),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[

                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(top:18.0,bottom: 18),
                         
                         ),
                       ),
                       
                        Material(
                          
                          elevation:1,
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
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
                          
                                    padding: EdgeInsets.all(0.8),
                                    icon: Icon(
                                      Icons.apps,
                                      color: Colors.white,
                                      size: 40,
                                      ),
                                      
                                    onPressed: (){
                                      var route =  MaterialPageRoute(builder: (context)=>AppDrawer());
                                      Navigator.of(context).push(route);
                                    },)
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
                        )
                     ],
                   ),
                
           ),
      
        
      ),

    );
  }
}



