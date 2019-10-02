import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swey/DataBase/db.dart';
import 'package:swey/allapps.dart';
import 'package:swey/systemconfig.dart';


class AppSetUp extends StatefulWidget {
  @override
  _AppSetUpState createState() => _AppSetUpState();
}

class _AppSetUpState extends State<AppSetUp> {

  List<Apps> temp=AllApps.apps;

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
     
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,),onPressed: ()=>Navigator.of(context).pop(),),
      
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
                        children: List.generate(AllApps.apps.length, (i) {
                          return Container(
                          height: 105,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: (){},
                              child: Center(
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CheckBox(AllApps.apps[i]),
                                    Center(child: Text(AllApps.apps[i].appNmae.toString().split(" ")[0].split("_")[0]))
                                    
                                  ],
                                ) 
                              ),
                            )
                            
                           
                          ),
                          
                        );
                         }),
                 ): Center()
            ),
             Padding(
                padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                child:Container(
                    height: 40,
                 child: TextField(
                  controller: _controller,
                  onChanged: (text){
                        setState(() {
                          temp = AllApps.apps.where((apps)=>apps.appNmae.toLowerCase().startsWith(_controller.text.toLowerCase())).toList();
                          
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


class CheckBox extends StatefulWidget {
  Apps i;
  CheckBox(this.i);
  @override
  _CheckBoxState createState() => _CheckBoxState(i);
}

class _CheckBoxState extends State<CheckBox> {
  Color color = Colors.grey.withOpacity(0.4);
  bool added = false;
  Apps i;
  _CheckBoxState(this.i);


  @override
  void initState() {
    super.initState();
   if(SystemConfig.appNames!=null){ 
    if(SystemConfig.appNames.contains(i.packageName)){
       color = Colors.red.withOpacity(0.8);
       added = true;

      }
    }else{
      SystemConfig.appNames=[];
      
    }
  }
  static const methodChannel = const MethodChannel("com.Cipher");

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
              setState(() {
                         if(!added){
                              color = Colors.red.withOpacity(0.8);
                              added=true;
                              SystemConfig.appNames.add(i.packageName);
                              SystemConfig.apps.add(i);
                         }else{
                               color = Colors.grey.withOpacity(0.4);
                               SystemConfig.appNames.remove(i.packageName);
                               SystemConfig.apps = SystemConfig.apps.where((test)=>SystemConfig.appNames.contains(test.packageName)).toList();
                               added=false;
                         }
                         db_handler.store.record("Apps").update(db_handler.db, SystemConfig.appNames);
                         methodChannel.invokeMethod("LoadApps",{"Apps":SystemConfig.appNames+["com.Cipher.swey","com.android.systemui","android"]});
                     });
      },
      child: CircleAvatar(
          
          backgroundColor: Colors.transparent,
          backgroundImage: i.appIcon.image,
          radius: 28,
          child: Padding(
                     padding: EdgeInsets.only(top:35,left: 35),
                     child: Icon(CupertinoIcons.check_mark_circled_solid,color: color,),
            ),
        
        ),
    );
    
    
    
    
  }

}


