//
//  LoadingViewController.swift
//  RemitaPaymentGateway
//
//  Created by Diagboya Iyare on 30/08/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import UIKit
import WebKit

class LoadingViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {

    var webView: WKWebView!
    var paymentRequest: PaymentRequest!
    var delegate: RemitaPaymentGatewayDelegate!
    
    var url: String = ""
    var publicKey: String = ""
    var email: String = ""
    var amount:  String = ""
    var phoneNumber: String = ""
    var firstName:  String = ""
    var lastName: String = ""
    var customerId: String = ""
    var currency: String = ""
    var transactionId: String = ""
    var narration:  String = ""

    
override func viewDidLoad()
{
   super.viewDidLoad()
 
  let htmlString: String = """
    <!DOCTYPE html>
    <html lang="en">
    <header><meta name="viewport" content="initial-scale=1.0" /></header>
    <body  onload="makePayment()">
    <script>
    function makePayment() {
    var paymentEngine = RmPaymentEngine.init({key:'\(publicKey)',
    email: "\(email)",
    currency: "\(currency)",
    firstName: "\(firstName)",
    lastName: "\(lastName)",
    customerId: "\(customerId)",
    phoneNumber: "\(phoneNumber)",
    transactionId:"\(transactionId)",
    narration: "\(narration)",
    amount: "\(amount)",
    onSuccess: function (response) {
    console.log(JSON.stringify(response));
    },
    onError: function (response) {
    console.log(JSON.stringify(response));
    },
    onClose: function () {
    console.log("closed");
    },
    });
    paymentEngine.openIframe();
    }
    </script>
    <script type="text/javascript" src="\(url)/payment/v1/remita-pay-inline.bundle.js"\\> </script>
    </body>
    </html>
"""
    
    webView.loadHTMLString(htmlString, baseURL: nil)
}

    
public override func loadView() {
 
    let wkWebViewConfig = WKWebViewConfiguration()
    
    let source = """
     function captureLog(msg) {
     window.webkit.messageHandlers.iosListener.postMessage(msg);
    }
    window.console.log = captureLog;
    
    """

    let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)

    wkWebViewConfig.userContentController.addUserScript(script)
    wkWebViewConfig.userContentController.add(self, name: "iosListener")
    webView = WKWebView(frame: .zero, configuration: wkWebViewConfig)
    webView.contentMode = .scaleToFill
    webView.uiDelegate = self
    view = webView
    self.amount = paymentRequest.amount
    self.url = paymentRequest.url
    self.publicKey = paymentRequest.key
    self.email = paymentRequest.email
    self.currency = paymentRequest.currency
    self.firstName = paymentRequest.firstName
    self.lastName = paymentRequest.lastName
    self.customerId = paymentRequest.customerId
    self.phoneNumber = paymentRequest.phoneNumber
    self.transactionId = paymentRequest.transactionId
    self.narration = paymentRequest.narration
    
    delegate = clientDelegate
 }
    
func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
 {
   let response = "\(message.body)"

   switch response
   {
   
    case "closed":
             self.close()
    
    default:
        var paymentResponse = PaymentResponse()
        
        let jsonData =  response.data(using: .utf8)!
        let responseData = try! JSONDecoder().decode(PaymentResponseData.self,from: jsonData)
        
        if case responseData.paymentReference = responseData.paymentReference, !responseData.paymentReference.isEmpty {
            
            paymentResponse.responseCode = Constants.SUCCESS_CODE.rawValue
            paymentResponse.responseMessage = Constants.SUCCESS_MESSAGE.rawValue
            paymentResponse.paymentResponseData = responseData
            
            delegate.onPaymentCompleted(paymentResponse: paymentResponse)

        } else {
              
            paymentResponse.responseCode = Constants.SUCCESS_CODE.rawValue
            paymentResponse.responseMessage = Constants.SUCCESS_MESSAGE.rawValue
            paymentResponse.paymentResponseData = responseData
            
            delegate.onPaymentCompleted(paymentResponse: paymentResponse)

         }
    
    }
}
 
override open var shouldAutorotate: Bool {
        return false
   }

override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   }
}


