//
//  ContanctsTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 13/6/21.
//

import UIKit

class ContanctsTableViewCell: UITableViewCell {

    static let identifier = "ContanctsTableViewCell"
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func loadData(email: String, telephone: String?) {
        var text = String()
        text.append("Email: \(email)")
        if let telephone = telephone {
            text.append("\nTelephone: \(telephone)")
        }
        label.text = text
    }
}
