//
//  Constants.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import Foundation

struct Constants {
    private static let serverURL = "http://192.168.1.84:9595"
    struct urls {
        static let kStatusOk = 200..<300
        static var articles: String {
            serverURL + "/api/articles"
        }
        static var posts: String {
            serverURL + "/api/forum"
        }
        static var films: String {
            serverURL + "/api/films"
        }
        static var characters: String {
            serverURL + "/api/characters"
        }
        static var users: String {
            serverURL + "/api/user"
        }
        static var tokens: String {
            serverURL + "/api/token"
        }
        static var rankings: String {
            serverURL + "/api/ranking"
        }
        static var answers: String {
            serverURL + "/api/answer"
        }
    }
    static var actualUser = UserRepository(id: nil, username: nil, is_newsPaperman: false, is_superuser: false, verified_email: false)
    static var token: String = ""
}
