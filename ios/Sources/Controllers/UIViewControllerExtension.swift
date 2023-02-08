//
//  UIViewControllerExtension.swift
//  RemitaPaymentGateway
//
//  Created by Diagboya Iyare on 30/08/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    struct Holder {
        static var _modalPrensentingViewController: UIViewController = UIViewController()
        static var _clientDelegate: RemitaPaymentGatewayDelegate? = nil
    }
    
    var modalPresentingViewController: UIViewController {
        get {
            return Holder._modalPrensentingViewController
        }
        set {
            Holder._modalPrensentingViewController = newValue
        }
    }
    
    var clientDelegate: RemitaPaymentGatewayDelegate? {
        get {
            return Holder._clientDelegate
        }
        set {
            Holder._clientDelegate = newValue
        }
    }
    
    func close() {
        modalPresentingViewController.dismiss(animated: true, completion: nil)
    }
    
}
