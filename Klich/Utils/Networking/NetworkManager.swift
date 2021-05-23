//
//  NetworkManager.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import Foundation

class NetworkManager {
    static func get<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(String(data: data!, encoding: .utf8) as Any)
                
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data, let stringError = String(data: data, encoding: .utf8) {
                    let error = NSError(domain: stringError, code: 0, userInfo: nil)
                    completion(.failure(error))
                }

                let error = NSError(domain: "Response != 200", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            print(String(data: data!, encoding: .utf8) as Any)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(T.self, from: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func post<T: Encodable, D: Decodable>(_ url: URL, data: T, completion: @escaping (Result<D, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try encoder.encode(data)
        } catch {
            completion(.failure(error))
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(String(data: data!, encoding: .utf8) as Any)
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data,
                   let detail = try? JSONDecoder().decode(ErrorDetail.self, from: data) {
                    let error = NSError(domain: detail.detail, code: 0, userInfo: nil)
                    completion(.failure(error))
                    return
                }

                let error = NSError(domain: "Response != 200", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            print(String(data: data!, encoding: .utf8) as Any)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(D.self, from: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
