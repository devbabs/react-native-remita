//
//  RemitaPaymentGateway
//
//  Created by Diagboya Iyare on 30/08/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import Foundation

struct PaymentRequest:Codable {
    var key  = ""
    var ref  = ""
    var email  = ""
    var amount  = ""
    var currency  = ""
    var firstName  = ""
    var lastName = ""
    var customerId  = ""
    var transactionId  = ""
    var narration  = ""
    var phoneNumber = ""
    var url = ""
    
    init() {
    }
}

public struct PaymentResponse: Codable {
    var responseCode = ""
    var responseMessage = ""
    var paymentResponseData : PaymentResponseData?
}

public struct PaymentResponseData: Codable {
    var paymentReference = ""
    var processorId = ""
    var transactionId = ""
    var message = ""
    var amount: Double = 0.0
    init(){}
}
