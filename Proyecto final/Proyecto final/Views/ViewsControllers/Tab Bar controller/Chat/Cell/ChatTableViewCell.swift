//
//  ChatTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var lblUsername: UILabel!
    
    static var identifier =
    "ChatTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        lblUsername.font = .primary14
        tintColor = .white
        layer.onlyShadow()
        accessoryType = .disclosureIndicator
        backgroundColor = .white.withAlphaComponent(0.1)
        lblUsername.textColor = .SithLord.white
    }
    
    func loadData(username: String) {
        lblUsername.text = username
    }
}
