//
//  PostTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    static let identifier = "PostTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        lblTitle.font = .primary16
        backgroundColor = .clear
        selectionStyle = .none
        lblAuthor.font = .systemFont(ofSize: 12)
    }
    
    func loadData(title: String, username: String, post: Bool = false) {
        lblTitle.text = title
        lblAuthor.text = username
        if !post {
            leftConstraint.constant = 8
            rightConstraint.constant = 24
        } else {
            leftConstraint.constant = 24
            rightConstraint.constant = 8
            lblTitle.font = .primary12
        }
    }
}
