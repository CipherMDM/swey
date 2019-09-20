import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swey/allapps.dart';
import 'package:swey/settingsconfig.dart';
import 'package:swey/setup/appsetup.dart';
import 'package:swey/setup/permissionspage.dart';

class SetUp extends StatefulWidget {
  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  TextEditingController _controller = new TextEditingController();
 
  
  
  
  
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.redAccent,),onPressed: (){},)
        ],
        title: Center(child: Text("Admin SetUp",style: TextStyle(color: Colors.black),),),
        
        
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
                               Text(SettingsConfig.wifi,style: TextStyle(fontSize: 14),),
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
                                       setState(() {
                                         SettingsConfig.wifi="on";
                                       });
                                       Navigator.of(context).pop();
                                     },
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Always off"),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.wifi="off";
                                       });
                                        Navigator.of(context).pop();
                                     },
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.wifi="user";
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
                               Text(SettingsConfig.hotspot,style: TextStyle(fontSize: 14),),
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
                                       });
                                        Navigator.of(context).pop();
                                     },
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Always off"),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.hotspot="off";
                                       });
                                        Navigator.of(context).pop();
                                     },
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                     onPressed: (){
                                       setState(() {
                                        SettingsConfig.hotspot="user";
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
                               Text(SettingsConfig.bluetooth,style: TextStyle(fontSize: 14),),
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
                                       });
                                        Navigator.of(context).pop();
                                     },
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Always off"),
                                      onPressed: (){
                                       setState(() {
                                         SettingsConfig.bluetooth="off";
                                       });
                                        Navigator.of(context).pop();
                                     },
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                      onPressed: (){
                                       setState(() {
                                         SettingsConfig.bluetooth="user";
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
                               Text(SettingsConfig.aeroplane_mode,style: TextStyle(fontSize: 14),),
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
                                       });
                                        Navigator.of(context).pop();
                                     },
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Always off"),
                                      onPressed: (){
                                       setState(() {
                                         SettingsConfig.aeroplane_mode="off";
                                       });
                                        Navigator.of(context).pop();
                                       }
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                      onPressed: (){
                                       setState(() {
                                         SettingsConfig.aeroplane_mode="user";
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
                               Text(SettingsConfig.mobile_data,style: TextStyle(fontSize: 14),),
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
                                       });
                                        Navigator.of(context).pop();
                                       }
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Always off"),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.mobile_data="off";
                                       });
                                        Navigator.of(context).pop();
                                       }
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow user",style: TextStyle(color: Colors.red),),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.mobile_data="user";
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
                               Text(SettingsConfig.sound,style: TextStyle(fontSize: 12),),
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
                                       });
                                        Navigator.of(context).pop();
                                       }
                                     
                                   ),
                                   CupertinoDialogAction(
                                     child: Text("Allow",style: TextStyle(color: Colors.red),),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.sound="Allow";
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
                              Text(SettingsConfig.camera,style: TextStyle(fontSize: 12),),
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
                                       });
                                        Navigator.of(context).pop();
                                       }
                                     
                                   ),
                                  
                                   CupertinoDialogAction(
                                     child: Text("Allow",style: TextStyle(color: Colors.red),),
                                     onPressed: (){
                                       setState(() {
                                         SettingsConfig.camera="Allow";
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
                         ListTile(
                          leading: Icon(Icons.bookmark,color: Colors.blueAccent),
                          title: Text("Permissions",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                            var route = CupertinoPageRoute(builder: (context)=>PermissionsPage());
                            Navigator.push(context, route);
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