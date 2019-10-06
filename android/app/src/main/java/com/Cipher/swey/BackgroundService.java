package com.Cipher.swey;

import android.app.Service;
import android.app.AlarmManager;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;
import android.view.KeyEvent;
import java.util.*;
import android.os.Handler;
import 	java.lang.reflect.Method;
import android.app.usage.UsageStatsManager;
import 	android.app.usage.UsageStats;
import android.view.View;
import 	android.view.ViewGroup;
import android.view.MotionEvent;
import android.view.Gravity;
import android.graphics.PixelFormat;
import android.provider.Settings;
import android.view.WindowManager;
import android.view.Window;
import android.view.GestureDetector;
import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;
import android.content.ComponentName;
import android.app.admin.DevicePolicyManager;
import android.app.ActivityManager;
import android.app.admin.DeviceAdminReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.content.pm.PackageManager;
import android.app.PendingIntent;
import android.content.pm.PackageInstaller;
import android.Manifest;
import android.app.Service;
import android.content.*;
import android.os.*;
import android.widget.Toast;
import android.net.Uri;

public class BackgroundService extends Service {

    public Context context = this;
    public Handler handler = null;
    public static Runnable runnable = null;
    
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }


    @Override
    public void onCreate() {
        
        handler = new Handler();
        runnable = new Runnable() {
            public void run() {            
                String recent = "";
                String current = getForegroundApp();
                if(!AllowedApps.Apps.contains(current)){
                //   if(current!=recent && current!="com.android.settings"){
                //        Toast.makeText(context, current+" blocked by swey", Toast.LENGTH_LONG).show();
                //        recent=current;
                //   }
                   
                    showHomeScreen();
                  }
                handler.postDelayed(runnable, 1000);
            }
        };
        Thread thread = new Thread(runnable);
        thread.start();
    }

    @Override
    public void onDestroy() {
         startActivity(new Intent(Settings.ACTION_SETTINGS));
    }

    @Override
    public void onStart(Intent intent, int startid) {
        onCreate();
     
    }


    public String getForegroundApp() {
        String currentApp = "NULL";
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            UsageStatsManager usm = (UsageStatsManager) this.getSystemService(Context.USAGE_STATS_SERVICE);
            long time = System.currentTimeMillis();
            List<UsageStats> appList = usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, time - 1000 * 1000, time);
            if (appList != null && appList.size() > 0) {
                SortedMap<Long, UsageStats> mySortedMap = new TreeMap<Long, UsageStats>();
                for (UsageStats usageStats : appList) {
                    mySortedMap.put(usageStats.getLastTimeUsed(), usageStats);
                }
                if (mySortedMap != null && !mySortedMap.isEmpty()) {
                    currentApp = mySortedMap.get(mySortedMap.lastKey()).getPackageName();
                }
            }
        } else {
            ActivityManager am = (ActivityManager) this.getSystemService(Context.ACTIVITY_SERVICE);
            List<ActivityManager.RunningAppProcessInfo> tasks = am.getRunningAppProcesses();
            currentApp = tasks.get(0).processName;
        }

        System.out.println(currentApp+"  "+AllowedApps.Apps);
    
        return currentApp;
    }
    
    public boolean showHomeScreen(){
        
        Intent startMain = new Intent(Intent.ACTION_MAIN);
        startMain.addCategory(Intent.CATEGORY_HOME);
        startMain.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(startMain);
        return true;
    }

}