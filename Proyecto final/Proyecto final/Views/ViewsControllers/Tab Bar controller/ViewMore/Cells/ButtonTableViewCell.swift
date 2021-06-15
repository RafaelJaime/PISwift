//
//  ButtonTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 13/6/21.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnJoin: UIButton!
    
    private var eventDelegate: EventDelegate?
    static let identifier = "ButtonTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
        btnJoin.normalStyle(color: .lightsaber.red)
        if let eventDelegate = eventDelegate {
            if eventDelegate.isOnEvent {
                btnJoin.normalStyle(color: .lightsaber.red)
                btnJoin.setTitle("Disjoin", for: .normal)
            } else {
                btnJoin.normalStyle(color: .lightsaber.green)
                btnJoin.setTitle("Join", for: .normal)
            }
        }
    }
    
    func loadData(delegate: EventDelegate) {
        eventDelegate = delegate
        style()
    }
    
    @IBAction func actionJoin(_ sender: Any) {
        eventDelegate?.joinEvent()
        style()
    }
    
}
