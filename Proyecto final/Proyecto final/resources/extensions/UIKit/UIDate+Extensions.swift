//
//  UIDate+Extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import UIKit

extension Date {
//    Volver aquí
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY MM dd"
        return dateFormatter.string(from: self)
    }
}
