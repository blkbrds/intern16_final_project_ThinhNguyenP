//
//  LoginViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

final class LoginViewModel {
    var name: String
    var password: String
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    
    
//    enum LoginResult {
//        case success
//        case failure(Bool, String)
//    }
//
//    // MARK: - typealias
//    typealias Completion = (LoginResult) -> Void
//
//    // MARK: - Properties
//    var email: String = ""
//    var password: String = ""
//
//    // MARK: - Actions
//    func login(email: String, password: String, completion: Completion) {
//        if email == "" || password == "" {
//            //callback
//            completion(.failure(true, "Mật khẩu hoặc email rỗng."))
//        } else {
//            //cập nhật dữ liệu
//            self.email = ""
//            self.password = ""
//
//            //save data
//            DataManager.shared().save(email: email, password: password)
//
//            //callback
//            completion(.success)
//        }
//    }
//
//    func login(email: String, password: String, completion: (Bool) -> ()) {
//        if email == "" || password == "" {
//            completion(false)
//        } else {
//            completion(true)
//        }
//    }
//
//
//}
//
//class User {
//    var
}
