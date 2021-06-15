//
//  LateralMenuViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 6/6/21.
//

import UIKit

struct MenuField {
    let titulo: String
    let image: UIImage?
    let action: MenuFieldAction
}

enum MenuFieldAction {
    case viewController(UIViewController)
    case navigationController(UIViewController)
    case action
}

class LateralMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var menuFields = [MenuField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        registerCell()
    }

    func style() {
        title = "Main Menu"
        navigationController?.blackBackgroundWithoutSideMenu()
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .SithLord.lightDark
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController")
        menuFields.append(MenuField(titulo: "Main", image: nil, action: .navigationController(vc)))
        vc = storyBoard.instantiateViewController(withIdentifier: "MenuViewController")
        menuFields.append(MenuField(titulo: "Ranking", image: nil, action: .navigationController(vc)))
        vc = storyBoard.instantiateViewController(withIdentifier: "FilmsViewController")
        menuFields.append(MenuField(titulo: "Films", image: nil, action: .navigationController(vc)))
        vc = storyBoard.instantiateViewController(withIdentifier: "CharactersViewController")
        menuFields.append(MenuField(titulo: "Characters", image: nil, action: .navigationController(vc)))
//        menuFields.append(MenuField(titulo: "Menciones", image: nil, action: .action))
        menuFields.append(MenuField(titulo: "Logout", image: nil, action: .action))
    }
}

extension LateralMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: MenuTableViewCell.self), bundle: nil), forCellReuseIdentifier: MenuTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier) as? MenuTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        newCell.loadData(titulo: menuFields[indexPath.row].titulo, image: menuFields[indexPath.row].image)
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuFields[indexPath.row].action {
        case .navigationController(let nav):
            let view = nav
            view.modalPresentationStyle = .fullScreen
            present(view, animated: false, completion: nil)
        case .viewController(let vc):
            let view = UINavigationController()
            view.setViewControllers([vc], animated: true)
            vc.title = menuFields[indexPath.row].titulo
            view.blackBackground(vc)
            view.modalPresentationStyle = .fullScreen
            present(view, animated: false, completion: nil)
        case .action:
            Constants.actualUser = UserRepository(id: nil, username: nil, is_newsPaperman: false, is_superuser: false)
            Constants.token = ""
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LogingViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
