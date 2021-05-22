//
//  Models.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

struct Token: Codable {
    let token: String
}

struct User: Codable {
    let username: String
    let password: String?
}
