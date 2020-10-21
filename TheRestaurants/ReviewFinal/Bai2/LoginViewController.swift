//
//  LoginViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var model = Model2()
    func updateView() {
        emailTextField.text = viewModel.name
        passwordTextField.text = viewModel.password
    }
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        Model2.shared.
        for item in Model2 {
            if emailTextField.text == item.username && passwordTextField.text == item.password  {
                let vc = HomeViewController()
                vc.name = item.username
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            }
        }
            
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
   
            // tao gia tri cho closure
            let complete: LoginViewModel.Completion = { (result) in
                switch result {
                case .success:
                    //làm cái gi đó
                    print("ĐĂNG NHẬP THÀNH CÔNG")
                    self.updateView()
                    
                    //thay đổi root
                    let scene = UIApplication.shared.connectedScenes.first
                    if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                        sd.changeScreen(type: .tabbar)
                    }
                case .failure(let isError, let errorMsg):
                    if isError {
                        print("ĐĂNG NHẬP THẤT BẠI")
                        print(errorMsg)
                    }
                }
            }
            
            // goi ham
            viewModel.login(email: email, password: password, completion: complete)
        }
}
