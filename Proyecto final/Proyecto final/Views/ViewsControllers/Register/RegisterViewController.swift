//
//  RegisterViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 13/6/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
    }
    
    func style() {
        view.backgroundColor = UIColor(patternImage: .space)
        tfUsername.blackStyle()
        tfPassword.blackStyle()
        tfRepeatPassword.blackStyle()
        
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.titleLabel?.tintColor = .SithLord.lightDark
        btnRegister.backgroundColor = .SithLord.darkYellow
        btnRegister.layer.cornerRadius = 5
    }
    @IBAction func actionRegister(_ sender: Any) {
        if let username = tfUsername.text, let password = tfPassword.text, let repeater = tfRepeatPassword.text {
            if password == repeater {
                NetworkingProvider.shared.newUser(user: NetworkingProvider.userRegister(username: username, password: password)) {
                    LogingViewController.doLogin(self, username: username, password: password)
                } failiture: { [weak self] error in
                    self?.showAlert("Error", message: "Something has gone wrong", withOneAction: "Okey")
                    print(error?.localizedDescription)
                }

            } else {
                showAlert("Error", message: "Passwords must match", withOneAction: "Okey")
            }
        }
        
    }
    
}
