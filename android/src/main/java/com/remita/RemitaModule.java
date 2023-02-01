package com.devbabs.reactnative.remita;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;

import com.remita.paymentsdk.core.RemitaInlinePaymentSDK;
import com.remita.paymentsdk.data.PaymentResponse;
import com.remita.paymentsdk.util.JsonUtil;
import com.remita.paymentsdk.util.RIPGateway;

import com.remita.paymentsdk.listener.RemitaGatewayPaymentResponseListener;

import java.util.Date;
import java.util.Objects;
import com.facebook.react.bridge.Callback;

@ReactModule(name = RemitaModule.NAME)
public class RemitaModule extends ReactContextBaseJavaModule implements RemitaGatewayPaymentResponseListener {
    public static final String NAME = "Remita";

    String apiKey;
    String environment;
    Callback paymentCompleted;

    @ReactMethod
    public void init(String apiKey, String environment) {
        this.apiKey = apiKey;
        this.environment = environment;
    }

    public RemitaModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @ReactMethod
    public void pay(String amount, String email, String phone, String firstName, String lastName, String currencyCode, String narration, String transactionId, Callback paymentCompleted) {

        String url = (Objects.equals(this.environment, "demo")) ? RIPGateway.Endpoint.DEMO : RIPGateway.Endpoint.PRODUCTION;
        String api_key = this.apiKey;

        this.paymentCompleted = paymentCompleted;

        Activity currentActivity = getCurrentActivity();

        RemitaInlinePaymentSDK remitaInlinePaymentSDK = RemitaInlinePaymentSDK.getInstance();
        remitaInlinePaymentSDK.setRemitaGatewayPaymentResponseListener(RemitaModule.this);

        remitaInlinePaymentSDK.initiatePayment(currentActivity, url, api_key, email,
                amount, currencyCode, firstName, lastName, email, phone, transactionId, narration);
    }

    @Override
    public void onPaymentCompleted(PaymentResponse paymentResponse) {
        if(!Objects.equals(JsonUtil.toJson(paymentResponse), "{}")) { // This condition helps with a bug on the Remita Android SDK, that calls this method even when the transaction has not been done yet
            this.paymentCompleted.invoke(JsonUtil.toJson(paymentResponse));
        }
    }
}
