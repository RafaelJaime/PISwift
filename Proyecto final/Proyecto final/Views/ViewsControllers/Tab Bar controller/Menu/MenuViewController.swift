//
//  MenuViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 2/6/21.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var cvMenu: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "add"
        navigationController?.blackBackground(self)
        
        cvMenu.delegate = self
        cvMenu.dataSource = self
        cvMenu.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCell")
    }

}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCollectionViewCell
        guard let newCell = cell else { return UICollectionViewCell() }
        newCell.backgroundColor = .red
        newCell.lblTitle?.text = "HOLA"
        return newCell
    }
    
    
}
