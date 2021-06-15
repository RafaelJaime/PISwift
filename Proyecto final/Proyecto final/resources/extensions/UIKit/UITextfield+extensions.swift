//
//  UITextfield+extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 13/6/21.
//

import UIKit

extension UITextField {
    func blackStyle() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor.SithLord.white])
        backgroundColor = .SithLord.lightDark
        textColor = .SithLord.white
    }
}
