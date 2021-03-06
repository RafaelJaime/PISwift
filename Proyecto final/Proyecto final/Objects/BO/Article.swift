//
//  Article.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import Foundation
struct ArticleBO {
    let id: Int
    let image: String?
    let author: UserBO
    let title, subtitle, content: String
    let createdAt: String?
    let event: EventBO?

    enum CodingKeys: String, CodingKey {
        case id, image, author, title, subtitle, content
        case createdAt
        case event
    }
}

struct UserBO: Codable {
    let id: Int?
    let username: String?
    let is_newsPaperman, is_superuser: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case is_newsPaperman
        case is_superuser
    }
}

// MARK: - ArticleEvent
struct EventBO {
    let id: Int
    let title: String
    let image, latitude, longitude, telephone: String?
    let email, eventDescription, startDate, endDate: String?
    let participants: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title, image, latitude, longitude, telephone, email
        case eventDescription
        case startDate, endDate, participants
    }
}
