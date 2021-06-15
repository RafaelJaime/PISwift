//
//  MenuTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 6/6/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    static let identifier = "MenuTableViewCell"
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.onlyShadow()
        lblTitle.textColor = .SithLord.white
    }
    
    func loadData(titulo: String, image: UIImage?) {
        lblTitle.text = titulo
        if let image = image {
            ivImage.image = image
        }
    }
}
