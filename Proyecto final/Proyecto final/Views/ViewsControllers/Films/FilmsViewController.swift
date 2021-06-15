//
//  FilmsViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 6/6/21.
//

import UIKit

class FilmsViewController: UIViewController {

    @IBOutlet weak var tvFilms: UITableView! {
        didSet {
            tvFilms.tableFooterView = UIView(frame: .zero)
        }
    }
    
    private var films = Film()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        registerTable()
    }
    
    func style() {
        title = "Films"
        navigationController?.blackBackground(self)
        
        tvFilms.backgroundColor = .SithLord.lightDark
        
        NetworkingProvider.shared.getFilm { [weak self] films in
            self?.films = films
            self?.tvFilms.reloadData()
        } error: {
            self.showAlert("Error", message: "An error has occurred", withOneAction: "Ok")
        }
    }
}

extension FilmsViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTable() {
        tvFilms.delegate = self
        tvFilms.dataSource = self
        tvFilms.register(UINib(nibName: String(describing: FilmsTableViewCell.self), bundle: nil), forCellReuseIdentifier: FilmsTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmsTableViewCell.identifier, for: indexPath) as? FilmsTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        print(films[indexPath.row])
        newCell.loadData(title: films[indexPath.row].title, people1: films[indexPath.row].director, people2: films[indexPath.row].producer, date: films[indexPath.row].releaseDate)
        
        return newCell
    }
}
