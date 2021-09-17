//
//  ViewController.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 19/08/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usenameView: UIView!
    @IBOutlet	 weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var listUser = [User]()
    

    var presenter: LogInPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LogInPresenter(view: self)
        presenter.fetchData()
        layoutConfig()
    }
    private func layoutConfig(){
        loginButton.layer.cornerRadius = loginButton.bounds.height/2
        
        usenameView.layer.cornerRadius = 25
        usenameView.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.4823529412, blue: 0.1176470588, alpha: 1)
        usenameView?.layer.borderWidth = 1
        
        passwordView.layer.cornerRadius = 25
        passwordView.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.4823529412, blue: 0.1176470588, alpha: 1)
        passwordView.layer.borderWidth = 1
    }
    
    @IBAction func onPressButton(_ sender: Any) {
        self.presenter?.verify(userName: nameTF.text!, password: passwordTF.text!)
    }
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension ViewController: LogInPresenterDelegate {
    func loginSuccess() {
        goToTabbar()
    }
    
    func goToTabbar(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {
                    return
                }
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = .clear
                present(vc, animated: true, completion: nil)
    }
}
