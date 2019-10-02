package com.Cipher.swey;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.widget.Toast;;


public class BootCompletedIntentReceiver extends BroadcastReceiver {
 @Override
 public void onReceive(Context context, Intent intent) {
  if ("android.intent.action.BOOT_COMPLETED".equals(intent.getAction())) {
    Toast.makeText(context, "Kiosk activated by boot!", Toast.LENGTH_LONG).show();
     Intent intent2 = new Intent(context, BackgroundService.class);
     context.startService(intent2);
  }
 }
}