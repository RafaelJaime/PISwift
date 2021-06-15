//
//  DateTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    
    static let identifier = "DateTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func loadData(date: String, toDate: String?) {
        var message = String()
        message.append(date.dateDMY)
        if let todate = toDate {
            message.append(" to ")
            message.append(todate.dateDMY)
        }
        
        lblDate.text = message
    }
    
}
