package com.nativebridge;

import android.provider.Settings;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class CustomModule extends ReactContextBaseJavaModule {

    private static ReactApplicationContext reactContext;

    CustomModule(ReactApplicationContext context) {
        super(context);
        reactContext = context;
    }

    @ReactMethod
    public void show() {
        Toast.makeText(reactContext, "hello this is first app", Toast.LENGTH_LONG).show();
    }

    @ReactMethod
    public void deviceId(Promise promise) {
        try {
            String android_id = Settings.Secure.getString(reactContext.getContentResolver(),
                    Settings.Secure.ANDROID_ID);
            promise.resolve(android_id);
        } catch (Exception e) {
            promise.reject("Error", e);
        }
    }

    @ReactMethod
    public void sayHello(String name, Callback callback) {
        try {

            String message = "Hello" + name;
            callback.invoke(null, message);
        } catch (Exception e) {
            callback.invoke(e, null);

        }
    }

    @NonNull
    @Override

    public String getName() {
        return "CustomModule";
    }

}
