//
//  film.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import Foundation

// MARK: - FilmElement
struct FilmElement: Codable {
    let id: Int
    let title, director, producer, releaseDate: String?
    let characters: Characters
    let likes: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title, director, producer
        case releaseDate = "release_date"
        case characters, likes
    }
}

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name, actor: String
    let image: String?
    let likes: [Int]
}

typealias Characters = [Character]


typealias Film = [FilmElement]

//TOKEN
struct token: Encodable {
    let user: String
    let password: String
    
//    enum CodingKeys: String, CodingKey {
//        case username
//        case password
//    }
}
struct tokenResponse: Decodable {
    let successful: Bool
    let user: UserRepository
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case successful
        case user
        case token
    }
}
