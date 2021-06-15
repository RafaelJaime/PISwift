//
//  EmptyTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    static var identifier = "EmptyTableViewCell"
    
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMessage.font = .primary12
        lblMessage.textColor = .white
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
