//
//  LoginViewController.swift
//  Bai2Review
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var viewModel = LoginViewModel()
//    private func login() {
//        guard let userName = userNameLabel.text, let password = passwordLabel.text else { return }
//        for i in dataUser {
//            if i.
//        }
////        if userName == viewModel.userName && password == viewModel.
//    }
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        for (id, password) in viewModel.userName {
            if id == userNameTextField.text && password == passwordTextField.text {
                let vc = HomeViewController()
                vc.viewModel.id.append(id)
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}
