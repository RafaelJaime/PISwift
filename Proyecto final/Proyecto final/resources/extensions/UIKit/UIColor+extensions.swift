//
//  UIColor+extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 29/5/21.
//

import Foundation
import UIKit

extension UIColor {
    class SithLord {
        static var lightDark: UIColor {
            UIColor(red: 36, green: 36, blue: 36, alpha: 1.0)
        }
        
        static var white: UIColor {
            UIColor(red: 223, green: 223, blue: 223, alpha: 1.0)
        }
        
        static var darkYellow: UIColor {
            UIColor(red: 219, green: 169, blue: 13, alpha: 1.0)
        }
        static var blue: UIColor {
            UIColor(red: 45, green: 43, blue: 60, alpha: 1.0)
        }
        static var red: UIColor {
            UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
    class Republic {
        static var blue: UIColor {
            UIColor(red: 46, green: 85, blue: 124, alpha: 1.0)
        }
        
        static var green: UIColor {
            UIColor(red: 51, green: 78, blue: 48, alpha: 1.0)
        }
    }
    
    class lightsaber {
        static var lightBlue: UIColor {
            UIColor(red: 21, green: 242, blue: 253, alpha: 1)
        }
        
        static var blue: UIColor {
            UIColor(red: 46, green: 103, blue: 248, alpha: 1)
        }
        
        static var green: UIColor {
            UIColor(red: 47, green: 249, blue: 35, alpha: 1)
        }
        
        static var red: UIColor {
            UIColor(red: 235, green: 33, blue: 46, alpha: 1)
        }
        
        static var yellow: UIColor {
            UIColor(red: 255, green: 232, blue: 31, alpha: 1)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
}
