//
//  ViewMoreViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 5/6/21.
//

import UIKit

protocol update {
    func update() -> Void
    func showAlert(_ viewController: String, message: String, withOneAction: String)
}

class ViewMoreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    private var show = [showMore]()
    private var gotEvent: Bool
    private var buttonIsVisible: Bool
    private var bottomConstraint: CGFloat = 0
    var isOnEvent: Bool
    var event: EventBO?
    var post: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        registerCell()
    }
    
    func style() {
        tableView.backgroundColor = .SithLord.lightDark
        tableViewBottomConstraint.constant = bottomConstraint
        btnEvent.backgroundColor = .SithLord.red
        btnEvent.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btnEvent.layer.cornerRadius = 0.5 * btnEvent.bounds.size.width
        btnEvent.isHidden = !gotEvent
        btnBottom.bottomStyle(title: "Answer")
        btnBottom.isHidden = buttonIsVisible
    }
    
    init(shows: [showMore], button: Bool = false, event: Bool = false, post: Int? = nil) {
        if !button {
            bottomConstraint = 60
        }
        buttonIsVisible = button
        gotEvent = event
        isOnEvent = false
        self.post = post
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
        show = shows
        print(show)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func actionAnswer(_ sender: Any) {
        if let post = post {
            let alert = showAlert("Form", message: "Complete the form to add the post", textfields: ["Title"])
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { _ in
                let title = alert.textFields![0]
                if let id = Constants.actualUser.id, let title = title.text {
                    NetworkingProvider.shared.postAnswer(post: NetworkingProvider.answerResponse(answer: title, author: id, post: post)) {
                        let vc = UIApplication.getPresentedViewController() as? update
                        vc?.update()
                        _ = self.navigationController?.popViewController(animated: true)
                        vc?.showAlert("Success", message: "Answer create correctly", withOneAction: "Okey")
                    } error: {
                        self.showAlert("Error", message: "Answer could not be created", withOneAction: "Okey")
                    }
                }
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionEvent(_ sender: Any) {
        print("lo intenta")
        if let event = event {
            goToEvent(event: event)
        }
    }
}

extension ViewMoreViewController: UITableViewDelegate, UITableViewDataSource {
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: EmptyTableViewCell.self), bundle: nil), forCellReuseIdentifier: EmptyTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: TitleTableViewCell.self), bundle: nil), forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: SubtitleTableViewCell.self), bundle: nil), forCellReuseIdentifier: SubtitleTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: TextTableViewCell.self), bundle: nil), forCellReuseIdentifier: TextTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: DateTableViewCell.self), bundle: nil), forCellReuseIdentifier: DateTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: EventTableViewCell.self), bundle: nil), forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: ButtonTableViewCell.self), bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.identifier)
        tableView.register(UINib(nibName: String(describing: ContanctsTableViewCell.self), bundle: nil), forCellReuseIdentifier: ContanctsTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        show.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch show[indexPath.row] {
        case .post(let title, let author):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(title: title, username: author)
            return newCell
        case .noAnswers:
            print("NO ANSWERS")
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            return newCell
        case .answer(let answerText, let author):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(title: answerText, username: author, post: true)
            return newCell
        case .title(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(title: title)
            return newCell
        case .subtitle(let subtitle):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier, for: indexPath) as? SubtitleTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(subtitle: subtitle)
            return newCell
        case .text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(text: text)
            return newCell
        case .date(let date, let todate):
            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as? DateTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(date: date, toDate: todate)
            return newCell
        case .event(let event):
            let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell
            self.event = event
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(event: event, delegate: self)
            return newCell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as? ButtonTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(delegate: self)
            return newCell
        case .contacts(let email, let telephone):
            let cell = tableView.dequeueReusableCell(withIdentifier: ContanctsTableViewCell.identifier, for: indexPath) as? ContanctsTableViewCell
            guard let newCell = cell else { return UITableViewCell() }
            newCell.loadData(email: email, telephone: telephone)
            return newCell
        default:
            print("Not yet")
            return UITableViewCell()
        }
    }
}

extension ViewMoreViewController: EventDelegate {
    func goToEvent(event: EventBO) {
        
        var eventShow = [showMore]()
        eventShow.append(.title(event.title))
        if let startDate = event.startDate {
            eventShow.append(.date(startDate, event.endDate))
        }
        
        if let subtitle = event.eventDescription {
            eventShow.append(.subtitle(subtitle))
        }
        if let email = event.email {
            eventShow.append(.contacts(email, event.telephone))
        }
        eventShow.append(.button)
        
        let vc = ViewMoreViewController(shows: eventShow, button: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func joinEvent() {
        if isOnEvent {
            print("GetOuttheevent")
        } else {
            print("Go to event")
        }
        isOnEvent.toggle()
        tableView.reloadData()
    }
}
