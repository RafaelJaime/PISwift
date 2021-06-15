//
//  EventTableViewCell.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

protocol EventDelegate {
    var isOnEvent: Bool { get set }
    var event: EventBO? { get set }
    func goToEvent(event: EventBO)
    func joinEvent()
}

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnInfomation: UIButton!
    @IBOutlet weak var btnJoin: UIButton!
    
    static let identifier = "EventTableViewCell"
    
    private var eventDelegate: EventDelegate?
    private var event: EventBO?
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
        btnInfomation.normalStyle()
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
    
    func loadData(event: EventBO, delegate: EventDelegate) {
        if let description = event.eventDescription {
            lblDescription.text = description
        } else {
            lblDescription.text = event.title
        }
        self.event = event
        eventDelegate?.event = event
        eventDelegate = delegate
        
        if let id = Constants.actualUser.id {
            if event.participants.contains(id) {
                eventDelegate?.isOnEvent = true
            }
        }
        style()
    }
    @IBAction func actionInformation(_ sender: Any) {
        showEvent()
    }
    
    @IBAction func actionJoin(_ sender: Any) {
        eventDelegate?.joinEvent()
        style()
    }
    
    func showEvent() {
        if let event = self.event {
            eventDelegate?.goToEvent(event: event)
        }
    }
}
