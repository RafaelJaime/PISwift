//
//  CharactersTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblActor: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    static let identifier = "CharactersTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    func style() {
        backgroundColor = .clear
        selectionStyle = .none
        lblName.font = .primary14
        lblActor.font = .primary12
        ivImage.image = .starWars
    }
    
    func loadData(name: String, actor: String, image: UIImage = UIImage.starWars) {
        lblName.text = name
        lblActor.text = actor
        ivImage.image = image
    }
    
}
