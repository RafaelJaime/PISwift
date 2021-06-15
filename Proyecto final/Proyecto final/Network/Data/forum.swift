//
//  forum.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import Foundation

// MARK: - PostElement
struct PostElement: Codable {
    let id: Int
    let author: User
    let answers: [Answer]
    let title: String
}

// MARK: - Answer
struct Answer: Codable {
    let author: User
    let id: Int
    let answer: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username: String
}

typealias Post = [PostElement]
