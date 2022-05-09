package com.nativebridge;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeArray;
import com.facebook.react.bridge.WritableNativeMap;

import java.util.ArrayList;
import java.util.List;

public class Contact extends ReactContextBaseJavaModule {
    private static ReactApplicationContext reactContext;
    public static final int REQUEST_READ_CONTACTS = 79;
    ArrayList<ContactModel> arrayList = new ArrayList<ContactModel>();

    //    MainAdapter adapter;
    Contact(ReactApplicationContext context) {
        super(context);
        reactContext = context;
    }

  @ReactMethod
    public void GetDetails() {

    }


    @ReactMethod
    public void getContact( Promise promise) {
        //Initialize uri
        Uri uri = ContactsContract.Contacts.CONTENT_URI;
        //Sort by ascending
        String sort = ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME + " ASC";
        //Initialize cursor
        Cursor cursor = getReactApplicationContext().getContentResolver().query(
                uri, null, null, null, sort
        );

        //check condition
        if (cursor.getCount() == 0) {
            String e = " getting error";

        } else {
            while (cursor.moveToNext()) {
                @SuppressLint("Range") String id = cursor.getString(cursor.getColumnIndex(
                        ContactsContract.Contacts._ID
                ));
                @SuppressLint("Range") String name = cursor.getString(cursor.getColumnIndex(
                        ContactsContract.Contacts.DISPLAY_NAME
                ));
                Uri uriPhone = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
                Log.d("uriPhone", String.valueOf(uriPhone));
                String selection = ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " =?";
                Cursor phoneCursor = getReactApplicationContext().getContentResolver().query(
                        uriPhone, null, selection, new String[]{id}, null
                );

                if (phoneCursor.moveToNext()) {
                    @SuppressLint("Range") String number = phoneCursor.getString(phoneCursor.getColumnIndex((
                            ContactsContract.CommonDataKinds.Phone.NUMBER
                    )));
                    ContactModel model = new ContactModel();
                   
                    model.setName(name);
                    model.setNumber(number);
                    arrayList.add(model);
                    phoneCursor.close();
                }
            }

            try {
                WritableArray batchResults = new WritableNativeArray();

                for (ContactModel details : arrayList) {
                    WritableMap resultData = new WritableNativeMap();
                    resultData.putString("name", details.name);
                    resultData.putString("number", details.number);
                    batchResults.pushMap(resultData);
                }
                Log.d("details", String.valueOf(batchResults));
//                callback.invoke(batchResults);
                promise.resolve(batchResults);
            } catch (Exception e) {
                promise.reject(e);

            }


            cursor.close();

        }
    }

    @NonNull
    @Override
    public String getName() {
        return "Contact";
    }
}

