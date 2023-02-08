#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import "Remita-Bridging-Header.h"
//#import <RemitaPaymentGateway/RemitaPaymentGateway.h>
//#import "RemitaPaymentGateway"
//#import <RemitaPaymentGateway/Sources/RemitaPaymentGateway.h>


@interface RCT_EXTERN_MODULE(Remita, NSObject)

RCT_EXPORT_METHOD(pay)
{
//    const paymentGateway: RemitaPaymentGateway = RemitaPaymentGateway();
//    paymentGateway.delegate = self;
    
    RCTLogInfo(@"Attempting to pay");
}

RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)name location:(NSString *)location)
{
 RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
