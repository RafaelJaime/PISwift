//
//  ForumViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import UIKit

class ForumViewController: UIViewController {
    @IBOutlet weak var tvForum: UITableView! {
        didSet {
            tvForum.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var btnBottom: UIButton!
    
    private var posts = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Forum"
        navigationController?.blackBackground(self)
        registerTable()
        style()
    }
    
    func style() {
        tvForum.backgroundColor = .SithLord.blue
        btnBottom.bottomStyle(color: .lightsaber.blue, title: "New Post")
        NetworkingProvider.shared.getForum { [weak self] posts in
            self?.posts = posts
            self?.tvForum.reloadData()
        } error: { [weak self] in
            self?.showAlert("Error", message: "Server not avatible", withOneAction: "OK")
        }
        
    }
    @IBAction func actionForum(_ sender: Any) {
        let alert = showAlert("Form", message: "Complete the form to add the post", textfields: ["Title"])
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { _ in
            let title = alert.textFields![0]
            if let id = Constants.actualUser.id, let title = title.text {
                if !title.isEmpty {
                    NetworkingProvider.shared.postPost(post: NetworkingProvider.postResponse(title: title, author: id)) {
                        self.showAlert("Success", message: "Forum create correctly", withOneAction: "Okey")
                        self.style()
                    } error: {
                        self.showAlert("Error", message: "Forum could not be created", withOneAction: "Okey")
                    }
                } else {
                    self.showAlert("Error", message: "Text field can not be empty", withOneAction: "Okey")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ForumViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTable() {
        tvForum.delegate = self
        tvForum.dataSource = self
        tvForum.register(UINib(nibName: String(describing: ForumTableViewCell.self), bundle: nil), forCellReuseIdentifier: ForumTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForumTableViewCell.identifier, for: indexPath) as? ForumTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        newCell.loadData(title: posts[indexPath.row].title, username: posts[indexPath.row].author.username)
        newCell.layer.onlyShadow()
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var comments = [showMore]()
        comments.append(.post(posts[indexPath.row].title, posts[indexPath.row].author.username))
        if posts[indexPath.row].answers.isEmpty {
            comments.append(.noAnswers)
        } else {
            for answer in posts[indexPath.row].answers {
                comments.append(.answer(answer.answer, answer.author.username))
            }
        }
        
        let vc = ViewMoreViewController(shows: comments, button: false, post: posts[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if Constants.actualUser.is_superuser {
            let trashAction = UIContextualAction(style: .normal, title: "Delete", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                print("Action delete")
                success(true)
            })
            trashAction.backgroundColor = .lightsaber.red
            trashAction.image = .init(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [trashAction])
        } else {
            return nil
        }
    }
}
// MARK: - update
extension ForumViewController: update {
    func update() {
        self.style()
    }
}
