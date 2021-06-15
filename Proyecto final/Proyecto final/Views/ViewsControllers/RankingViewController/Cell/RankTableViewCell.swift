//
//  RankTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 13/6/21.
//

import UIKit

class RankTableViewCell: UITableViewCell, filmRank {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfRank: UITextField!
    
    var rank: Int?
    var film: Int?
    
    static let identifier = "RankTableViewCell"
    
    func getRank() -> Int? {
        if let actualRank = tfRank.text {
            return Int(actualRank)
        }
        return nil
    }
    func getFilmID() -> Int? {
        if let actualRank = film {
            return Int(actualRank)
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfRank.keyboardType = .numberPad
        tfRank.delegate = self
    }
    
    func loadData(title: String, rank: Int?, film: Int) {
        lblTitle.text = title
        if let rank = rank {
            tfRank.text = String(rank)
            self.rank = rank
        }
        self.film = film
    }
}

extension RankTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
