//
//  String+Extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import Foundation

extension String {
    //    MARK: To URL
    var url: URL? {
        URL(string: self)
    }
    //    MARK: To date
    private static var commonDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    private static var highDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String.commonDateFormat
        return dateFormatter.date(from: self)
    }
    
    var dateDMY: String {
        getDateOnString(fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: "dd MMMM YYYY")
    }
    
    var dateMMDD: String {
        getDateOnString(fromFormat: .commonDateFormat, toFormat: "dd MMMM")
    }
    
    func getDateOnString(fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        guard let dateFinal = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dateFinal)
    }
    
    func getDate(fromFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        return dateFormatter.date(from: self)
    }
}
