//
//  OpenChatViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 3/6/21.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
//
//class OpenChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
//
//    let currentUser = Sender(senderId: "self", displayName: "IOS Academy")
//
//    let messages = [MessageType]()
//
//    func currentSender() -> SenderType {
//        currentUser
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        <#code#>
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        <#code#>
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//    }
//}
