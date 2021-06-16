//
//  RankingViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 6/6/21.
//

import UIKit

protocol filmRank {
    var rank: Int? { get set }
    var film: Int? { get set }
    func getRank() -> Int?
    func getFilmID() -> Int?
}
struct rankingBO {
    var film: Int
    var rank: Int
}

class RankingViewController: UIViewController {
    
    
    @IBOutlet weak var tvRanking: UITableView! {
        didSet {
            tvRanking.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var btnRanking: UIButton!
    
    private var films = [FilmElement]()
    private var ranking = [rankingBO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        registerTable()
    }
    
    func style() {
        title = "Ranking"
        navigationController?.blackBackground(self)
        tvRanking.backgroundColor = .SithLord.lightDark
        btnRanking.bottomStyle(title: "Save ranking")
        tvRanking.alwaysBounceVertical = false
        tvRanking.allowsSelection = false
        NetworkingProvider.shared.getFilm { [weak self] filmsRepository in
            for film in filmsRepository {
                if let self = self {
                    self.films.append(film)
                }
            }
            if let id = Constants.actualUser.id {
                NetworkingProvider.shared.getRanking(id: id) { rankings in
                    for actualRanking in rankings {
                        if let film = actualRanking.film, let rank = actualRanking.rank {
                            self?.ranking.append(rankingBO(film: film.id, rank: rank))
                        }
                    }
                    self?.tvRanking.reloadData()
                } error: { [weak self] in
                    self?.showAlert("Error", message: "Server error", withOneAction: "Okey")
                }
            }
        } error: { [weak self] in
            self?.showAlert("Error", message: "Server error", withOneAction: "Okey")
        }
    }
    
    @IBAction func actionSave(_ sender: Any) {
        print("Has pulsado el botón enviar")
        var avalibleNumbers = [Int]()
        guard films.count > 0 else { showAlert("Error", message: "Not films avalible", withOneAction: "Okey"); return }
        for actual in 1...films.count {
            avalibleNumbers.append(actual)
        }
        var array = [rankingBO]()
        var number = 0
        
        for film in 0..<films.count {
            let indexPath = IndexPath(row: film, section: 0)
            let tableViewCell = tvRanking.cellForRow(at: indexPath) as? filmRank
            if let rank = tableViewCell?.getRank() {
                if avalibleNumbers.contains(rank) {
                    if let number = avalibleNumbers.firstIndex(of: rank) {
                        avalibleNumbers.remove(at: number)
                    }
                } else {
                    showAlert("Error", message: "Each film must have different ranks and must be between 1 and \(films.count)", withOneAction: "Okey")
                }
                print("Pelicula: \(tableViewCell?.getFilmID()), rank: \(rank)")
                if let film = tableViewCell, let filmID = film.getFilmID() {
                    array.append(rankingBO(film: filmID, rank: rank))
                }
            }
        }
        var sortedArray = [rankingBO]()
        for film in 0...films.count {
            for arr in array {
                if arr.rank == film {
                    sortedArray.append(arr)
                }
            }
        }
        var message = "Your rank is: \n"
        
        for arr in sortedArray {
            for film in films {
                if film.id == arr.film {
                    if let title = film.title {
                        message.append("\(arr.rank) -> \(title)\n")
                    }
                }
            }
        }
        message.append("Are you sure you want to save this ranking?")
        showAlertWithCancellButton("Sure?", message: message, withOneAction: "Save rank") { _ in
            for film in array {
                
                NetworkingProvider.shared.ranking(rank: film.rank, film: film.film) { [weak self ] in
                    number += 1
                    if number == array.count {
                        self?.showAlert("Success", message: "Ranking saved correctly", withOneAction: "Okey")
                    }
                } failiture: { [weak self ] _ in
                    self?.showAlert("Error", message: "Try again later", withOneAction: "Okey")
                }
            }
        }
        print(message)
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath) as? RankTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        var exists: Int? = nil
        for rank in ranking {
            if rank.film == films[indexPath.row].id  {
                exists = rank.rank
            }
        }
        if let title = films[indexPath.row].title {
            newCell.loadData(title: title, rank: exists, film: films[indexPath.row].id)
        }
        
        return newCell
    }
    
    func registerTable() {
        tvRanking.delegate = self
        tvRanking.dataSource = self
        tvRanking.register(UINib(nibName: String(describing: RankTableViewCell.self), bundle: nil), forCellReuseIdentifier: RankTableViewCell.identifier)
    }
}
