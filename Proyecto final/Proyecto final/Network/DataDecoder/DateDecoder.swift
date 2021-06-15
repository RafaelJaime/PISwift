//
//  DateDecoder.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import Foundation

final class DateDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
