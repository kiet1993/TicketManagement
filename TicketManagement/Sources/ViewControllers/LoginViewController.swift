//
//  LoginViewController.swift
//  TicketManagement
//
//  Created by Phu Nguyen on 1/8/19.
//  Copyright © 2019 Nals. All rights reserved.
//

import UIKit
protocol LoginViewControllerDelegate {
    func canceled()
    func loginSuccess(with userId: String)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var textfieldUsername: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLoginTap(_ sender: Any) {
        if textfieldUsername.text == "admin" && textfieldPassword.text == "admin" {
            guard let name = textfieldUsername.text else { return }
            self.dismiss(animated: true, completion: nil)
            self.delegate?.loginSuccess(with: name)
            return
        }
        print("Wrong username or password")
    }
    
    @IBAction func btnCancelTap(_ sender: Any) {
        dismiss(animated: true) { [unowned self] in
            self.delegate?.canceled()
        }
    }
}
