//
//  CharactersViewController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 6/6/21.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var tvCharacters: UITableView! {
        didSet {
            tvCharacters.tableFooterView = UIView(frame: .zero)
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    private var characters = Characters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        registerTable()
    }
    
    func style() {
        title = "Characters"
        navigationController?.blackBackground(self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add.withTintColor(.white), style: .done, target: self, action: #selector(addCharacter))
        tvCharacters.backgroundColor = .SithLord.lightDark
        NetworkingProvider.shared.getCharacter { [weak self] chars in
            self?.characters = chars
            self?.tvCharacters.reloadData()
        } error: {
            self.showAlert("Error", message: "An error has occurred", withOneAction: "Ok")
        }
    }
    
    @objc func addCharacter() {
        print("Add character button")
        let alert = self.showAlert(nil, message: "Complete the form to add a character", textfields: ["Character", "Actor name", "Biography"])
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { _ in
            let character = alert.textFields![0]
            let actor = alert.textFields![1]
            let biography = alert.textFields![2]
            
            if let id = Constants.actualUser.id, let character = character.text, let actor = actor.text, let biography = biography.text {
                print("Character: \(character)\nActor name: \(actor)\nBiography: \(biography)\n")
                if !character.isEmpty || !actor.isEmpty || !biography.isEmpty {
                    print("Escribir en api")
                    let alert = UIAlertController(title: nil, message: "Choose your source", preferredStyle: .alert)

                      alert.addAction(UIAlertAction(title: "Camera", style: .default) { (result : UIAlertAction) -> Void in
                        print("Camera selected")
                        self.imagePicker.sourceType = .camera
                        self.present(self.imagePicker, animated: true, completion: nil)
                      })
                      alert.addAction(UIAlertAction(title: "Photo library", style: .default) { (result : UIAlertAction) -> Void in
                        print("Photo selected")
                        self.imagePicker.sourceType = .photoLibrary
                        self.present(self.imagePicker, animated: true, completion: nil)
                      })

                      self.present(alert, animated: true, completion: nil)
                } else {
                    self.showAlert("Error", message: "Text field can not be empty", withOneAction: "Okey")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTable() {
        tvCharacters.delegate = self
        tvCharacters.dataSource = self
        tvCharacters.register(UINib(nibName: String(describing: CharactersTableViewCell.self), bundle: nil), forCellReuseIdentifier: CharactersTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath) as? CharactersTableViewCell
        guard let newCell = cell else { return UITableViewCell() }
        newCell.loadData(name: characters[indexPath.row].name, actor: characters[indexPath.row].actor)
        
        return newCell
    }
    
    
}
