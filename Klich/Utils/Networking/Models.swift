//
//  Models.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: Int
    let name: String
}

struct Token: Codable {
    let token: String
    let userType: Int
}

struct User: Codable {
    let username: String?
    let password: String?
    let userType: Int?
    var fullName: String?
    var about: String?
}

struct ErrorDetail: Codable {
    let detail: String
}
