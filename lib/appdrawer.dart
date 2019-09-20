import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swey/settings.dart';
import 'package:swey/systemconfig.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController _controller = new TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
     
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: ()=>Navigator.of(context).pop(),),
        actions: <Widget>[IconButton(icon: Icon(Icons.settings,color: Colors.black,),onPressed: (){
          var route = CupertinoPageRoute(builder: (context)=>Settings());
          Navigator.push(context, route);
        },)],
      ),
      body: Column(children: <Widget>[

       
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Expanded(
            child: _controller.text.isEmpty?
           GridView.count(
                       
                  
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        
                        crossAxisCount: 4,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(SystemConfig.apps.length, (i) {
                          return Container(
                          height: 105,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: (){DeviceApps.openApp(SystemConfig.apps[i].packageName);},
                              child: Center(
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 55,
                                      child: SystemConfig.apps[i].appIcon,
                                    ),
                                    Center(child: Text(SystemConfig.apps[i].appNmae.toString().length>8?SystemConfig.apps[i].appNmae.toString().substring(0,8)+"..":SystemConfig.apps[i].appNmae.toString()))
                                    
                                  ],
                                ) 
                              ),
                            )
                          
                          ),
                          
                        );
                         }),
                 ):
            Container(

            ),
            ),
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
                      borderRadius: BorderRadius.circular(40)
                    )
                  ),
                ),
              ),
          ),
          Padding(padding: EdgeInsets.all(10),)
      ],),
     
    );
  }
}