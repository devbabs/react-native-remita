#import <React/RCTBridgeModule.h>
//#import <RemitaPaymentGateway/RemitaPaymentGateway.h>

@interface RCT_EXTERN_MODULE(Remita, NSObject)

RCT_EXTERN_METHOD(multiply:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
