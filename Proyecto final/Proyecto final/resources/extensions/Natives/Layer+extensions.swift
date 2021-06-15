//
//  Layer+extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import Foundation
import UIKit

extension CALayer {
    func fieldFormat() {
        cornerRadius = 2.0
        masksToBounds = false
        backgroundColor = UIColor.white.cgColor
        
        shadowRadius = 2.0
        shadowOpacity = 0.3
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 1.0, height: 2.0)
    }
    
    func onlyShadow() {
        shadowRadius = 2.0
        shadowOpacity = 0.3
        shadowColor = UIColor.gray.cgColor
        shadowOffset = CGSize(width: 1.0, height: 2.0)
    }
}
