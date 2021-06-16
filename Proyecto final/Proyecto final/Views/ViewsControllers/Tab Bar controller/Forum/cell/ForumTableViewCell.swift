//
//  ForumTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import UIKit

class ForumTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    static var identifier = "ForumTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        lblTitle.font = .primary12
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func loadData(title: String, username: String) {
        lblTitle.text = title.lowercased()
        lblUsername.text = username
    }
    
}
