//
//  KlichAPI.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

class KlichAPI {
    static let rootURL = URL(string: "https://klich-api.herokuapp.com/")!

    static func register(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("register")
        NetworkManager.post(url, data: user, completion: completion)
    }

    static func login(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("login")
        NetworkManager.post(url, data: user, completion: completion)
    }

    static func updateUser(_ user: User?, token: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let user = user else { return }
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("edit")
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        comps.queryItems = [
            URLQueryItem(name: "user_token", value: token)
        ]
        NetworkManager.post(comps.url!, data: user, completion: completion)
    }

    static func getProfile(token: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("profile")
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        comps.queryItems = [
            URLQueryItem(name: "user_token", value: token)
        ]
        NetworkManager.get(comps.url!, completion: completion)
    }

    static func getMyCategories(token: String, completion: @escaping (Result<[Category], Error>) -> Void) {
        let url = rootURL.appendingPathComponent("categories").appendingPathComponent("my")
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        comps.queryItems = [
            URLQueryItem(name: "user_token", value: token)
        ]
        NetworkManager.get(comps.url!, completion: completion)
    }
}
