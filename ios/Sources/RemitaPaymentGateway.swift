//
//  RemitaPaymentGateway.swift
//  RemitaPaymentGateway
//
//  Created by Diagboya Iyare on 30/08/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//


import UIKit

/**
 Remita Payment Gateway
 */

public class RemitaPaymentGateway: NSObject {
    /**
     Delegate reference
     */
    public var delegate: RemitaPaymentGatewayDelegate?
    
    /**
     This method should be called when the client is ready to initiate a payment
     - Parameter presentingViewController: View controller where the SDK's payment view is displayed modally on
     - Parameter paymentReference: Your transaction unique identifier
     - Parameter email: Your customer's email
     - Parameter amount: Transaction amount
     - Parameter currencyCode: Defaults to NGN
     - Parameter firstname: Your customer's firstname
     - Parameter lastername: Your customer's lastname
     - Parameter customerId: Your customer's unique identifier
     - Parameter narration: Description of the payment.
    */
    public func initiatePayment(on presentingViewController: UIViewController, url: String, key: String, email: String, amount: String, phoneNumber: String, firstname: String, lastname: String, customerId: String, currencyCode: String, transactionId: String, narration: String) {
               
        var paymentRequest = PaymentRequest()
        paymentRequest.url = url
        paymentRequest.key = key
        paymentRequest.email = email
        paymentRequest.amount = amount
        paymentRequest.phoneNumber = phoneNumber
        paymentRequest.firstName = firstname
        paymentRequest.lastName = lastname
        paymentRequest.customerId = customerId
        paymentRequest.currency = currencyCode
        paymentRequest.transactionId = transactionId
        paymentRequest.narration = narration
        
        let bundle = Bundle(for: LoadingViewController.self)
        let loadingViewController = LoadingViewController(nibName: String(describing: LoadingViewController.self), bundle: bundle)
        loadingViewController.modalPresentationStyle = .overFullScreen
        loadingViewController.modalPresentingViewController = presentingViewController
        loadingViewController.paymentRequest = paymentRequest
        loadingViewController.clientDelegate = delegate
        
        presentingViewController.present(loadingViewController, animated: true, completion: nil)
    }
}
