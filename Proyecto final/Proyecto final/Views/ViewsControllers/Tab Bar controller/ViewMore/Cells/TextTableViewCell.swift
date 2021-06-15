//
//  TextTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    static let identifier = "TextTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        lblText.tintColor = .white
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func loadData(text: String) {
        lblText.text = text
    }
}
