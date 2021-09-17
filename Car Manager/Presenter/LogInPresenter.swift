//
//  LogInPresenter.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 25/08/2021.
//

import Foundation
import UIKit
import Alamofire

protocol LogInPresenterDelegate: AnyObject {
    func loginSuccess()
}

class LogInPresenter: NSObject {
    var delegate: LogInPresenterDelegate?
    let baseUrl: String = "https://6139cd8b1fcce10017e78c34.mockapi.io/accounts"
    var listUser = [User]()
    
    func fetchData() {
        AF.request(baseUrl).response { [self] response in
            guard let data = response.data else {
                return
            }
            do {
                let accounts = try JSONDecoder().decode([User].self, from: data)
                self.listUser = accounts
            }
            catch {
                print("error")
            }
        }
    }
    
    
    init(view: LogInPresenterDelegate) {
        delegate = view
    }
    
    func verify(userName: String,password: String) {
        for user in listUser {
            if(userName == user.user_name && password == user.password ) {
                if(user.status == "true") {
                    delegate?.loginSuccess()
                }
            }
        }
    }
}
