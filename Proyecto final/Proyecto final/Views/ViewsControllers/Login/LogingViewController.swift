//
//  LogingViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 18/4/21.
//

import UIKit
import IQKeyboardManagerSwift

class LogingViewController: UIViewController {
    
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var ivStarWars: UIImageView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRestore: UIButton!
    @IBOutlet weak var vwmiddle: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: .space)
        ivStarWars.image = .starWars
        
        tfUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.SithLord.white])
        tfUsername.backgroundColor = .SithLord.lightDark
        tfUsername.textColor = .SithLord.white
        
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.SithLord.white])
        tfPassword.backgroundColor = .SithLord.lightDark
        tfPassword.textColor = .SithLord.white
        
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.titleLabel?.tintColor = .SithLord.lightDark
        btnLogin.backgroundColor = .SithLord.darkYellow
        btnLogin.layer.cornerRadius = 5
        
        btnRestore.setTitle("", for: .normal)
        btnRestore.titleLabel?.tintColor = .SithLord.darkYellow
        
        btnBottom.backgroundColor = .SithLord.lightDark
        btnBottom.titleLabel?.tintColor = .SithLord.white
        btnBottom.setTitle("Create a new account. Register for free.", for: .normal)
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.present(vc, animated: true)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        LogingViewController.doLogin(self, username: tfUsername.text ?? "", password: tfPassword.text ?? "")
    }
    static func doLogin(_ viewController: UIViewController, username: String, password: String) {
        NetworkingProvider.shared.postToken(user: token(user: username, password: password)) {
            print("Se ha completado correctamente")
            print(Constants.token)
            if Constants.actualUser.verified_email {
                viewController.showAlert("Successful", message: "You have been logued correctly.", withOneAction: "Okey") { [weak viewController] _ in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //                let vc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                    if let tabViewController = storyboard.instantiateViewController(identifier: "TabBarViewController") as? UITabBarController {
                        tabViewController.modalPresentationStyle = .fullScreen
                        viewController?.present(tabViewController, animated: true, completion: nil)
                    }
    //                let nav = UINavigationController(rootViewController: vc)
    //                nav.modalPresentationStyle = .fullScreen
    //                viewController?.present(nav, animated: true, completion: nil)
                }
            } else {
                Constants.actualUser = UserRepository(id: nil, username: nil, is_newsPaperman: false, is_superuser: false, verified_email: false)
                Constants.token = ""
                viewController.showAlert("Alert!", message: "Please verify your email before enter the application", withOneAction: "Okey")
            }
        } error: {
            viewController.showAlert("Error", message: "something bad happened", withOneAction: "Okey")
        }
    }
}
