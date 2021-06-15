//
//  UIImageView+Extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL) {
        image = .starWars
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            } else {
                DispatchQueue.main.async() { [weak self] in
                    self?.image = .starWars
                }
            }
        }.resume()
    }
    
    func downloaded(from link: String?) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloaded(from: url)
        }
        else {
            image = .starWars
        }
    }
}
