//
//  SubtitleTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSubtitle: UILabel!
    
    static let identifier = "SubtitleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    func loadData(subtitle: String) {
        lblSubtitle.text = subtitle
    }
    
}
