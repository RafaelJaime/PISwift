//
//  Repository.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import UIKit
import Alamofire

final class NetworkingProvider {
    static let shared = NetworkingProvider()
    
//  MARK: - Get
    func getArticles(_ solution: @escaping (_ user: Article) -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.articles).responseDecodable(of: Article.self, decoder: DateDecoder()) { (response) in
            if response.error != nil {
                error()
            }
            if let user = response.value {
                solution(user)
            } else {
                print(response.error?.errorDescription ?? "Error no detectado")
            }
        }
    }
    
    func getForum(_ solution: @escaping (_ user: Post) -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.posts).responseDecodable(of: Post.self, decoder: DateDecoder()) { (response) in
            if response.error != nil {
                error()
            }
            if let user = response.value {
                solution(user)
            } else {
                print(response.error?.errorDescription ?? "Error no detectado")
            }
        }
    }
    
    func getFilm(_ solution: @escaping (_ user: Film) -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.films).responseDecodable(of: Film.self) { (response) in
            if response.error != nil {
                error()
            }
            if let user = response.value {
                print(user)
                solution(user)
            } else {
                print(response.error?.errorDescription ?? "Error no detectado")
            }
        }
    }
    
    func getCharacter(_ solution: @escaping (_ user: Characters) -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.characters).responseDecodable(of: Characters.self) { (response) in
            if response.error != nil {
                error()
            }
            if let user = response.value {
                print(user)
                solution(user)
            } else {
                print(response.error?.errorDescription ?? "Error no detectado")
            }
        }
    }
    struct RankingElement: Codable {
        let id: Int?
        let author: UserRepository?
        let rank: Int?
        let film: FilmElement?
    }

    typealias Ranking = [RankingElement]
    
    func getRanking(id: Int, solution: @escaping (_ user: Ranking) -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.rankings, method: .get, headers: ["id": String(id)]).responseDecodable(of: Ranking.self) { (response) in
            print("id: \(id), response: \(response)")
            if response.error != nil {
                error()
            }
            if let user = response.value {
                solution(user)
            } else {
                print(response.error?.errorDescription ?? "Error no detectado")
            }
        }
    }
    
//  MARK: - POST
    func postToken(user: token, _ solution: @escaping () -> Void, error: @escaping () -> Void) {
        AF.request(Constants.urls.tokens, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: Constants.urls.kStatusOk).responseDecodable(of: tokenResponse.self) { (response) in
            if let user = response.value {
                Constants.token = user.token
                Constants.actualUser = UserRepository(id: user.user.id, username: user.user.username, is_newsPaperman: user.user.is_newsPaperman, is_superuser: user.user.is_superuser)
                solution()
            } else {
                error()
            }
        }
    }
//    func postPost(message: String, _ solution: @escaping () -> Void, error: @escaping () -> Void) {
//        AF.request(Constants.urls.tokens, method: .post, parameters: ["author": Constants.actualUser.id, "title": message], encoder: JSONParameterEncoder.default).validate(statusCode: Constants.urls.kStatusOk).responseDecodable (of: [String: Bool].self) { (response) in
//            print(response)
//            if let user = response.value {
//                print(user)
//                Constants.token = user.token
//                Constants.actualUser = UserRepository(id: user.user.id, username: user.user.username, is_newsPaperman: user.user.is_newsPaperman, is_superuser: user.user.is_superuser)
//                solution()
//            } else {
//                error()
//            }
//        }
//    }
    
    struct postResponse: Codable {
        let title: String
        let author: Int
        
        enum CodingKeys: String, CodingKey {
            case title, author
        }
    }
    
    func postPost(post: postResponse, _ solution: @escaping () -> Void, error: @escaping () -> Void) {
    
        let headers: HTTPHeaders = [.authorization("Token " + Constants.token)]
        
        AF.request(Constants.urls.posts, method: .post, parameters: post, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: Constants.urls.kStatusOk).responseDecodable (of: [String: Bool].self) { (response) in
            print(response)
            if let respuesta = response.value {
                solution()
            } else {
                error()
            }
        }
    }
    
    struct answerResponse: Codable {
        let answer: String
        let author: Int
        let post: Int
        
        enum CodingKeys: String, CodingKey {
            case answer, author, post
        }
    }
    
    func postAnswer(post: answerResponse, _ solution: @escaping () -> Void, error: @escaping () -> Void) {
        
        let headers: HTTPHeaders = [.authorization("Token " + Constants.token)]
        
        AF.request(Constants.urls.answers, method: .post, parameters: post, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: Constants.urls.kStatusOk).responseDecodable (of: [String: Bool].self) { (response) in
            print(response)
            if let respuesta = response.value {
                solution()
            } else {
                error()
            }
        }
    }
    
//   MARK: - PUT
    struct userRegister: Encodable {
        let username, password: String
        
        enum CodingKeys: String, CodingKey {
            case username, password
        }
    }
    
    struct UserResponse: Codable {
        let successful: Bool
        let data: DataClass
    }
    struct DataClass: Codable {
        let username, password: String
    }
    
    func newUser(user: userRegister, success: @escaping ()-> Void, failiture: @escaping (_ error: Error?) -> ()) {
        AF.request(Constants.urls.users, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: Constants.urls.kStatusOk).responseDecodable (of: UserResponse.self) { response in
            if let user = response.value {
                print(user.successful)
                if !user.successful {
                    failiture(nil)
                }
                success()
            } else {
                failiture(response.error)
            }
        }
    }
    
    func ranking(rank: Int, film: Int, success: @escaping () -> Void, failiture: @escaping (_ error: Error?) -> ()) {
        
        let headers: HTTPHeaders = [.authorization("Token " + Constants.token)]
        
        AF.request(Constants.urls.rankings, method: .post, parameters: ["rank": rank, "film": film, "author": Constants.actualUser.id], encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: Constants.urls.kStatusOk).responseDecodable (of: [String: Bool].self) {response in
            if let user = response.value {
                print(response)
                success()
            } else {
                failiture(response.error)
            }
        }
    }
}
