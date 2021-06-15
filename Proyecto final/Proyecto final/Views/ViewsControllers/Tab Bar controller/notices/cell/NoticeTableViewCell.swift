//
//  NoticeTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 30/5/21.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vwShadow: UIView!
    
    static var identifier = "NoticeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .Republic.blue
        lblTitle.textColor = .SithLord.white
        lblTitle.font = .primary12
        lblDate.textColor = .SithLord.white
        lblDate.font = .primary12
        lblEvent.font = .primary12
        vwBottom.backgroundColor = .SithLord.blue
        vwShadow.addShadow(location: .bottom)
        selectionStyle = .none
    }
    
    func loadData(image: URL?, title: String, date: String?, event: String?) {
        if let im = image {
            ivImage.downloaded(from: im)
        }
        
        lblTitle.text = title
        if let dat = date {
            lblDate.text = dat.dateDMY
        }
        if let event = event {
            lblEvent.text = event
            ivIcon.image = .darthVader
        } else {
            ivIcon.isHidden = true
            lblEvent.isHidden = true
        }
    }
    
}
