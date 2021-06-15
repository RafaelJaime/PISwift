//
//  FilmsTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

class FilmsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPeople: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    static let identifier = "FilmsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
        lblTitle.font = .primary16
        lblPeople.font = .systemFont(ofSize: 14)
        lblReleaseDate.font = .primary14
    }
    
    func loadData(title: String?, people1: String?, people2: String?, date: String?) {
        if let title = title {
            lblTitle.text = title
        }
        var message = String()
        if let people = people1 {
            message.append("Director: \(people)\n")
        }
        
        if let people = people2 {
            message.append("Producer: \(people)\n")
        }
        lblPeople.text = message
        
        if let date = date {
            lblReleaseDate.text = date
        } else {
            lblReleaseDate.text = ""
        }
    }
    
}
