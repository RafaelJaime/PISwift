//
//  ProductTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 3/6/21.
//

import UIKit

struct Product {
    let id: Int
    let image: UIImage
    let title: String
    let cost: String
    let location: String
}
class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var vwLeft: UIView!
    @IBOutlet weak var vwRight: UIView!
    @IBOutlet weak var ivLeft: UIImageView!
    @IBOutlet weak var ivRight: UIImageView!
    @IBOutlet weak var lblTitleLeft: UILabel!
    @IBOutlet weak var lblTitleRight: UILabel!
    @IBOutlet weak var lblCostLeft: UILabel!
    @IBOutlet weak var lblCostRight: UILabel!
    @IBOutlet weak var lblDierctionLeft: UILabel!
    @IBOutlet weak var lblDirectionRight: UILabel!
    
    static var identifier = "ProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        vwLeft.layer.cornerRadius = 20
        vwRight.layer.cornerRadius = 20
    }
    
    func loadData(_ product1: Product, product: Product?) {
        ivLeft.image = product1.image
        lblTitleLeft.text = product1.title
        lblCostLeft.text = product1.cost
        lblDierctionLeft.text = product1.location
        if let product2 = product {
            ivRight.image = product2.image
            lblTitleRight.text = product2.title
            lblCostRight.text = product2.cost
            lblDirectionRight.text = product2.location
        }
    }
    
}
