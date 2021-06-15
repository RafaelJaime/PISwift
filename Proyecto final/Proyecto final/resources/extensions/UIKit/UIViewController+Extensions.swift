//
//  UIViewController+Extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import UIKit
extension UIViewController {
    //    MARK: - Alerts
    func getAlert(_ title: String, message: String, withOneAction actionText: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accion1 = UIAlertAction(title: actionText, style: .default, handler: nil)
        alert.addAction(accion1)
        return alert
    }
    
    func getAlert(_ title: String, message: String, withOneAction actionText: String, action: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accion1 = UIAlertAction(title: actionText, style: .default, handler: action)
        alert.addAction(accion1)
        return alert
    }
    
    func showAlert(_ title: String, message: String, withOneAction actionText: String) {
        let alert = self.getAlert(title, message: message, withOneAction: actionText)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String, message: String, withOneAction actionText: String, action: @escaping (UIAlertAction) -> Void) {
        let alert = self.getAlert(title, message: message, withOneAction: actionText,action: action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancellButton(_ title: String, message: String, withOneAction actionText: String, action: @escaping (UIAlertAction) -> Void) {
        let alert = self.getAlert(title, message: message, withOneAction: actionText,action: action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String?, message: String, textfields: [String]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for textfieldAdd in textfields {
            alert.addTextField { textfield in
                textfield.placeholder = textfieldAdd
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return alert
    }
}

extension UIApplication{
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController
        {
            presentViewController = pVC
        }
        
        return presentViewController
    }
}
