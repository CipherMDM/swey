import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swey/setUp.dart';
import 'package:swey/settingsconfig.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _controller = TextEditingController();
  static const methodChannel = const MethodChannel("com.Cipher");
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
        title: Center(child: Text("Settings",style: TextStyle(color: Colors.black),),),
        
        
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
              
            children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      
                       children: <Widget>[


                         (SettingsConfig.wifi=="user" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "wifi".startsWith(_controller.text.toLowerCase()))?
                          ListTile(
                          leading: Icon(Icons.wifi,color: Colors.orange,),
                           onTap: ()async{
                             await methodChannel.invokeMethod("OpenWifi");
                           },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Wifi",style: TextStyle(fontWeight: FontWeight.bold),),
                            
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),


                         (SettingsConfig.hotspot=="user" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "hotspot".startsWith(_controller.text.toLowerCase()))?
                          ListTile(
                          leading: Icon(Icons.wifi_tethering,color: Colors.blueGrey,),
                           onTap: ()async{
                             await methodChannel.invokeMethod("OpenHotSpot");
                           },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("HotSpot",style: TextStyle(fontWeight: FontWeight.bold),),
                            
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),

                          (SettingsConfig.bluetooth=="user" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "bluetooth".startsWith(_controller.text.toLowerCase())) ?
                          ListTile(
                          leading: Icon(Icons.bluetooth,color: Colors.blueAccent),
                           onTap: ()async{
                             await methodChannel.invokeMethod("OpenBluetooth");
                           },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Bluetooth",style: TextStyle(fontWeight: FontWeight.bold),),
                              
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),

                          (SettingsConfig.aeroplane_mode=="user" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "aeroplane mode".startsWith(_controller.text.toLowerCase())) ?
                           ListTile(
                          leading: Icon(Icons.airplanemode_active,color: Colors.lightBlueAccent),
                           onTap: ()async{
                             await methodChannel.invokeMethod("OpenAero");
                           },
                          
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Aeroplane mode",style: TextStyle(fontWeight: FontWeight.bold),),
                              
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),


                          (SettingsConfig.mobile_data=="user" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "mobile data".startsWith(_controller.text.toLowerCase()))?
                          ListTile(
                          leading: Icon(Icons.data_usage,color: Colors.green),
                            onTap: ()async{
                             await methodChannel.invokeMethod("OpenMobileData");
                           },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Mobile Data",style: TextStyle(fontWeight: FontWeight.bold),),
                              
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),

                          (SettingsConfig.sound=="Allow" && _controller.text.isEmpty) || (SettingsConfig.sound=="Allow" && "sound".startsWith(_controller.text.toLowerCase()))?
                           ListTile(
                          leading: Icon(Icons.music_note,color: Colors.indigoAccent),
                           onTap: ()async{
                             await methodChannel.invokeMethod("OpenSound");
                           },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Sound",style: TextStyle(fontWeight: FontWeight.bold),),
                              
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),):Center(),

                           
                       (_controller.text.isEmpty || "kiosk settings".startsWith(_controller.text.toLowerCase()))? ListTile(
                          leading: Icon(Icons.warning,color: Colors.red,),
                          title: Text("Kiosk Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                          onTap: (){
                               var route = CupertinoPageRoute(builder: (context)=>SetUp());
                               Navigator.push(context, route);
                          },
                          ):Center(),
                         
 


                       ],
                    )
                  ),
                ),
               
                
       
            ]
            ),
          ),
          
         
        ],
      ),
    );
  }
}