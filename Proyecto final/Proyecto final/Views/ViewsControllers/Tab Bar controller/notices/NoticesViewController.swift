//
//  NoticesViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 30/5/21.
//

import UIKit

class NoticesViewController: UIViewController {

    var menuController: UIViewController!
    var centerController: UIViewController!
    
    private var notices = [ArticleBO]()
    
    @IBOutlet weak var tvNotices: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notices"
        navigationController?.blackBackgroundtwoButtonItem(self, button: UIBarButtonItem())
//        if Constants.actualUser.is_superuser {
//            navigationController?.blackBackgroundtwoButtonItem(self, button: UIBarButtonItem())
//        } else {
//            navigationController?.blackBackground(self)
//        }
        
        NetworkingProvider.shared.getArticles { articles in
            print(articles)
            var sortedArticles = Article()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            for article in articles {
//                TODO
                if let created = article.createdAt {
                    let date = dateFormatter.date(from: created)
                    if let okey = date {
                        sortedArticles.append(article)
                    }
                }
            }
            
            var ready = sortedArticles.sorted(by: {guard let created = $1.createdAt else { return false}
                return $0.createdAt?.compare(created) == .orderedDescending
            })
            
            for article in articles {
                var participants = [Int]()
                var event: EventBO? = nil
                if let evento = article.event {
                    for participant in evento.participants {
                        participants.append(participant)
                    }
                    event = EventBO(id: evento.id, title: evento.title, image: evento.image, latitude: evento.latitude, longitude: evento.longitude, telephone: evento.telephone, email: evento.email, eventDescription: evento.eventDescription, startDate: evento.startDate, endDate: evento.endDate, participants: participants)
                }
                
                self.notices.append(ArticleBO(id: article.id, image: article.image, author: UserBO(id: article.author.id, username: article.author.username, is_newsPaperman: article.author.is_newsPaperman, is_superuser: article.author.is_superuser), title: article.title, subtitle: article.subtitle, content: article.content, createdAt: article.createdAt, event: event))
            }
            self.tvNotices.reloadData()
        } error: {
            self.showAlert("Error", message: "An error has occurred", withOneAction: "Ok")
        }
        registerTable()
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 0
            }, completion: nil)
        }
    }
    
    @objc func addNotice()  {
        print("crear noticia")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NoticesViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTable() {
        tvNotices.delegate = self
        tvNotices.dataSource = self
        tvNotices.backgroundColor = .SithLord.blue
        tvNotices.register(UINib(nibName: String(describing: NoticeTableViewCell.self), bundle: nil), forCellReuseIdentifier: NoticeTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        newCell.loadData(image: notices[indexPath.row].image?.url, title: notices[indexPath.row].title, date: notices[indexPath.row].createdAt, event: notices[indexPath.row].event?.startDate)
        
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notices[indexPath.row].id)
        var notice = [showMore]()
        notice.append(.title(notices[indexPath.row].title))
        if let date = notices[indexPath.row].createdAt {
            notice.append(.date(date, nil))
        }
        notice.append(.subtitle(notices[indexPath.row].subtitle))
        notice.append(.text(notices[indexPath.row].content))
        var event = false
        if let evento = notices[indexPath.row].event {
            event = true
            notice.append(.event(evento))
        }
        
        let vc = ViewMoreViewController(shows: notice, button: true, event: event)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashAction = UIContextualAction(style: .normal, title: "Delete", handler: {
            (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            print("Action delete")
            success(true)
        })
        trashAction.backgroundColor = .lightsaber.red
        trashAction.image = .init(systemName: "trash")
        trashAction.image = .init(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashAction = UIContextualAction(style: .normal, title: "Edit", handler: {
            (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            print("Action delete")
            success(true)
        })
        trashAction.backgroundColor = .lightsaber.yellow
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}
