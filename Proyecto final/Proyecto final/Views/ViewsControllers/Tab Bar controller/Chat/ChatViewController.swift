//
//  ChatViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tvChat: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        registerTable()
    }
    
    func style() {
        title = "chat"
        navigationController?.blackBackground(self)
        tvChat.backgroundColor = .SithLord.blue
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTable() {
        tvChat.delegate = self
        tvChat.dataSource = self
        tvChat.register(UINib(nibName: String(describing: ChatTableViewCell.self), bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as? ChatTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        newCell.loadData(username: "Paquito")
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        Show messages
    }
}
