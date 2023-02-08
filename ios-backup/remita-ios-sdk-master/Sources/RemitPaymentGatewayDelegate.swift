//
//  File.swift
//  RemitaPaymentGateway
//
//  Created by Diagboya Iyare on 30/08/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//


import Foundation
/**
 A delegate of the RemitaPaymentGateway must adopt the RemitaPaymentGatewayDelegate protocol.
 */
public protocol RemitaPaymentGatewayDelegate {
    /**
     Method is invoked when payment processing is completed
     */
   func onPaymentCompleted(paymentResponse: PaymentResponse)
   
}
