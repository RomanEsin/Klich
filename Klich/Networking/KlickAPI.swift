//
//  KlickAPI.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

class KlichAPI {
    static let rootURL = URL(string: "http://127.0.0.1:8000/")!

    static func register(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("register")
        NetworkManager.post(url, data: user, completion: completion)
    }

    static func login(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
        let url = rootURL.appendingPathComponent("user").appendingPathComponent("login")
        NetworkManager.post(url, data: user, completion: completion)
    }
}
