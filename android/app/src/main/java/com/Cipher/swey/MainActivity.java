package com.Cipher.swey;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.View;
import io.flutter.view.FlutterView;
import android.view.WindowManager;
import android.graphics.Color;
import android.view.Window;
import java.util.Arrays;
import android.content.Intent;
import android.app.admin.DevicePolicyManager;
import android.os.Bundle;
import android.app.Service;
import android.os.Handler;
import java.lang.reflect.Method;
import android.content.Context;
import android.os.StrictMode;
import android.os.StrictMode.VmPolicy.Builder;
import android.provider.Settings;


//premissions plugin
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.Intent;
import android.provider.Settings;
import android.content.Context;
import android.net.Uri;
import android.app.Activity;
import android.app.AppOpsManager;
import android.content.pm.PackageManager;
import android.Manifest;
import android.content.pm.ResolveInfo;
import android.content.ComponentName;
import android.content.IntentFilter;
import java.util.ArrayList;
import java.util.*;
import android.view.KeyEvent;







public class MainActivity extends FlutterActivity{

  private static final String CHANNEL = "com.Cipher";
  private static  FlutterView flutterView;
  boolean currentFocus;
  Context context=this;
  boolean isPaused;  
  Handler collapseNotificationHandler;
  Handler collapsePowerButtonHandler;



  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    
    if (BuildConfig.DEBUG) {

      StrictMode.VmPolicy policy = new StrictMode.VmPolicy.Builder()
                  .detectAll()
                  .penaltyLog()
                  .build();
      StrictMode.setVmPolicy(policy);

      StrictMode.ThreadPolicy policy2 = new StrictMode.ThreadPolicy.Builder()
           .detectAll()
           .penaltyLog()
           .build();
       StrictMode.setThreadPolicy(policy2);
  }
    flutterView=getFlutterView();
    hideSystemUI(flutterView);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
    new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
            if (call.method.equals("OpenHotSpot")) {
             
            }
            else if (call.method.equals("OpenWifi")) {
              startActivity(new Intent(Settings.ACTION_WIFI_SETTINGS));
            }
            else if (call.method.equals("OpenBluetooth")) {
              startActivity(new Intent(Settings.ACTION_BLUETOOTH_SETTINGS));
            }
            else if (call.method.equals("OpenSound")) {
              startActivity(new Intent(Settings.ACTION_SOUND_SETTINGS));
            }  
            else if (call.method.equals("OpenDisplay")) {
              startActivity(new Intent(Settings.ACTION_DISPLAY_SETTINGS));
            }  
            else if (call.method.equals("OpenMobileData")) {
              startActivity(new Intent(Settings.ACTION_DATA_ROAMING_SETTINGS));
            } 
            else if (call.method.equals("OpenAero")) {
              startActivity(new Intent(Settings.ACTION_AIRPLANE_MODE_SETTINGS));
            }  
            else if (call.method.equals("OpenSettings")) {
              startActivity(new Intent(Settings.ACTION_SETTINGS));
            }   

            //kiosk set up

            else if (call.method.equals("Activate")) {

                 Intent intent = new Intent(context, BackgroundService.class);
                 startService(intent);
               
            
            }  

            else if (call.method.equals("Deactivate")) {

                 Intent myService = new Intent(context, BackgroundService.class);
                 stopService(myService);
               
            
            }  

            else if (call.method.equals("LoadApps")) {
              List<String> _apps = call.argument("Apps");
              for(int i=0;i<_apps.size();i++){
                AllowedApps.Apps.add(_apps.get(i));
              }
             
            }
              
           else if (call.method.equals("isDebug")) {

                if(Settings.Secure.getInt(context.getContentResolver(), Settings.Secure.ADB_ENABLED, 0) == 1) {
                    // debugging enabled 
                     result.success(true);
                } else {
                    //;debugging does not enabled
                     result.success(false);
                }
              
             
            }

 
            else if (call.method.equals("OpenDev")) {
               startActivity(new Intent(android.provider.Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS));
              
            }  

           


        }  
    });

    
  }



  @Override
  public void onWindowFocusChanged(boolean hasFocus) {
      super.onWindowFocusChanged(hasFocus);
      if(!hasFocus)
      {
        Intent closeDialog=new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
        sendBroadcast(closeDialog);
       
       
      }
  }


  @Override
  public void onBackPressed() {
      return;
  }


  private void hideSystemUI(View view) {
   view.setSystemUiVisibility(
           View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                   | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                   | View.SYSTEM_UI_FLAG_IMMERSIVE);

   getWindow().getDecorView().setSystemUiVisibility(view.SYSTEM_UI_FLAG_IMMERSIVE_STICKY |
   view.SYSTEM_UI_FLAG_FULLSCREEN | view.SYSTEM_UI_FLAG_HIDE_NAVIGATION   | 
   view.SYSTEM_UI_FLAG_LAYOUT_STABLE | view.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION | view.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);               
  }


  



  

  
}
