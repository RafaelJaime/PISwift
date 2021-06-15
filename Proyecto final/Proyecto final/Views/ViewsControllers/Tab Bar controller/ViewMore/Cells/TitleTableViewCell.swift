//
//  TitleTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    static var identifier = "TitleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(title: String) {
        lblTitle.text = title
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
