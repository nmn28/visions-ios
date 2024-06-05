//
//  NetworkManager.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = URL(string: "http://localhost:3000")!
    
    private init() {}
    
    func performRequest<T: Decodable>(to endpoint: String,
                                      method: String,
                                      body: Data?,
                                      completion: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case noData
    case urlError
    case serverError
}

extension NetworkManager {
    func register(credentials: Credentials, completion: @escaping (Result<User, Error>) -> Void) {
        guard let body = try? JSONEncoder().encode(credentials) else {
            completion(.failure(NetworkError.noData))
            return
        }

        performRequest(to: "/register", method: "POST", body: body, completion: completion)
    }
    
        func login(credentials: Credentials, completion: @escaping (Result<User, Error>) -> Void) {
            guard let body = try? JSONEncoder().encode(credentials) else {
                completion(.failure(NetworkError.noData))
                return
            }

            performRequest(to: "/login", method: "POST", body: body, completion: completion)
        }
}

extension NetworkManager {
    func requestPasswordReset(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/password-reset") else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(.success(true))
                } else {
                    completion(.failure(NetworkError.serverError))
                }
            }
        }.resume()
    }
}
