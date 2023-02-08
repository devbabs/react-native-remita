//
//  CompletionViewController.swift
//  RemitaPaymentGatewayExampleSwift
//
//  Created by Joshua Balogun on 5/31/19.
//  Copyright © 2019  John Anwuna. All rights reserved.
//

import UIKit

class CompletionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var message: String!
    var code: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if code == "00" {
            imageView.image = #imageLiteral(resourceName: "success")
            statusLabel.text = "Transaction succcessful"
        } else {
            imageView.image = #imageLiteral(resourceName: "failure")
            statusLabel.text = "Transaction failed"
        }
    }
    
    @IBAction func payAgain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
