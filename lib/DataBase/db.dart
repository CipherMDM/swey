import 'package:sembast/sembast.dart';

mixin db_handler {
  static Database db;
  static var store = StoreRef.main();


  static make() async {
    store.record("Apps").exists(db).then((exist){
      if(!exist){
        store.record("Apps").add(db, [""]);
      }
    });
    
        
  }
 }