import 'package:flutter/material.dart';

class SystemConfig{

  static List<Apps> apps = [];
  static Map<String,String> settings = {}; 
  static List<String> appNames = [];
  static String version;
  static bool appdraw = false;
  static List<String> allsettings = [];

  SystemConfig.form(List<Apps> apps,List<String> appName,Map<String,String> settings){
           SystemConfig.apps=apps;
           SystemConfig.settings=settings;
           SystemConfig.appNames=appName;

  }

}

class Apps{
   String appNmae;
   String packageName;
   Image appIcon;
   Apps({this.appIcon,this.packageName,this.appNmae});
}