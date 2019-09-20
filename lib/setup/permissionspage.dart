import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permissions_kiosk/permissions_kiosk.dart';
// import 'package:permission_handler/permission_handler.dart';


class PermissionsPage extends StatefulWidget {
  @override
  _PermissionsState createState() => _PermissionsState();
}

class _PermissionsState extends State<PermissionsPage> {
  TextEditingController _controller = new TextEditingController();
  Color laun = Colors.transparent;
  Color usage = Colors.transparent;
  Color draw = Colors.transparent;
  Color write = Colors.transparent;
  Color perm = Colors.transparent;
  
  // List<PermissionGroup> permissionNameList = [           PermissionGroup.calendar,
  //                                                        PermissionGroup.camera,
  //                                                        PermissionGroup.storage,
  //                                                        PermissionGroup.contacts,
  //                                                        PermissionGroup.ignoreBatteryOptimizations,
  //                                                        PermissionGroup.locationWhenInUse,
  //                                                        PermissionGroup.sensors,
  //                                                        PermissionGroup.phone
  //                                                        ];

  // initSettings()async{

  //   await PermissionsKiosk.currentLauncher().then((islan){
  //                                                 if(islan){
  //                                              setState(() {
  //                                                laun = Colors.green;
  //                                              });
  //                                          }else{
  //                                               setState(() {
  //                                                laun = Colors.transparent;
  //                                              });
  //                                          }
  //                          });
  //   await PermissionsKiosk.isUsageSettings().then((isus){
  //                                            if(isus){
  //                                              setState(() {
  //                                                usage = Colors.green;
  //                                              });
  //                                          }else{
  //                                               setState(() {
  //                                                usage = Colors.transparent;
  //                                              });
  //                                          }
  //                          });     
  //   await PermissionsKiosk.isDrawSettings().then((isdr){
  //                                                 if(isdr){
  //                                              setState(() {
  //                                                draw = Colors.green;
  //                                              });
  //                                          }else{
  //                                               setState(() {
  //                                                draw = Colors.transparent;
  //                                              });
  //                                          }
  //                          });      
  //   await PermissionsKiosk.isWriteSettings().then((iswr){
  //                                                 if(iswr){
  //                                              setState(() {
  //                                                write = Colors.green;
  //                                              });
  //                                          }else{
  //                                               setState(() {
  //                                                write = Colors.transparent;
  //                                              });
  //                                          }
  //                          }); 


  //    for(int i=0;i<permissionNameList.length;i++){
  //      if(permisson.permissions.isNotEmpty){
  //        Future<List<PermissionStatus>> getval()async{
           
  //           return permisson.permissions.values.toList();
  //        }

  //        getval().then((stat){
  //          if(stat.contains(PermissionStatus.granted)){
  //            if(stat.contains(PermissionStatus.denied) || stat.contains(PermissionStatus.disabled) || stat.contains(PermissionStatus.unknown) || stat.contains(PermissionStatus.restricted)){
                    
  //                    setState(() {
  //                       perm = Colors.orange;
  //                    });
  //            }else{
  //               setState(() {
  //                       perm = Colors.green;
  //                    });
  //            }
  //          }

  //        });
            
  //      }
      
  //    }                      

  //   // Permission.getPermissionsStatus(permissionNameList).then((status){
  //   //        var stat = [];
  //   //        for(int i=0;i<status.length;i++){
  //   //         stat.add(status[i].permissionStatus);  
  //   //        }
  //   //        if(stat.contains(PermissionStatus.allow)){
  //   //          if(stat.contains(PermissionStatus.deny)){
                    
  //   //                  setState(() {
  //   //                     perm = Colors.orange;
  //   //                  });
  //   //          }else{
  //   //             setState(() {
  //   //                     perm = Colors.green;
  //   //                  });
  //   //          }
  //   //        }
  //   // });                                                                                             

  // }

  
  // Timer t;
  // @override
  // void initState() {
  //   initSettings();
  //   super.initState();
  //   t =  Timer.periodic(Duration(seconds: 1), (_)=> mounted? initSettings():null);
   
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   t.cancel();
  // }



 

  
  


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.transparent,),onPressed: (){},)
        ],
        centerTitle: true,
        title: Center(child: Text("Permissions",style: TextStyle(color: Colors.black),),),
        
        
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
                          leading: Icon(Icons.home,color: Colors.blueAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                               Text("Default Launcher",style: TextStyle(fontWeight: FontWeight.bold),),
                               Icon(CupertinoIcons.check_mark_circled_solid,color: laun,)
                            
                             
                              
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                           
                                        PermissionsKiosk.setLauncher();

                                        
                          
                               
                          },
                          ),
                         ListTile(
                          leading: Icon(Icons.access_time,color: Colors.lightBlueAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Enable Usage Access",style: TextStyle(fontWeight: FontWeight.bold),),
                               Icon(CupertinoIcons.check_mark_circled_solid,color: usage,)

                           
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                            
                                   PermissionsKiosk.getUsageSettings();  
                           
                          },
                          ),
                          ListTile(
                            
                          leading: Icon(Icons.blur_circular,color: Colors.green),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Overlay Permission",style: TextStyle(fontWeight: FontWeight.bold),),
                              Icon(CupertinoIcons.check_mark_circled_solid,color: draw,)
                               
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                                 
                                                       PermissionsKiosk.getDrawSettings();  
                                  
                             
                          },
                          ),
                          ListTile(
                          leading: Icon(Icons.settings,color: Colors.indigoAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Write Settings",style: TextStyle(fontWeight: FontWeight.bold),),  
                              Icon(CupertinoIcons.check_mark_circled_solid,color: write,)
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){

                                  
                                                       PermissionsKiosk.getWriteSettings();  
                                    
                           
                          },
                          ),
                          ListTile(
                          leading: Icon(Icons.security,color: Colors.pinkAccent),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Other Permissions",style: TextStyle(fontWeight: FontWeight.bold),),
                              Icon(CupertinoIcons.check_mark_circled_solid,color: perm,)
                             
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: ()async{
                            
                          //  permisson.permissions =  await PermissionHandler().requestPermissions(permissionNameList);
                           setState(() {
                             
                           });                                        
                                     
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
                          leading: Icon(Icons.people,color: Colors.deepPurple,),
                          title: Text("Activate Device Admin",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                            
                          },
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

// class permisson{
//   static Map<PermissionGroup, PermissionStatus> permissions={}; 
  
// }