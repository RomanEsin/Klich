//
//  UDManager.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

class UDManager {
    static func save(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    static func get(_ key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
