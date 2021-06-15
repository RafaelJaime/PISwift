//
//  ProductsViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 3/6/21.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var tvProducts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        registerCell()
    }
    
    func style() {
        title = "Products"
        navigationController?.blackBackground(self)
        tvProducts.backgroundColor = .SithLord.blue
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func registerCell() {
        tvProducts.delegate = self
        tvProducts.dataSource = self
        tvProducts.register(UINib(nibName: String(describing: ProductTableViewCell.self), bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        return newCell
    }
}
