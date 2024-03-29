//
//  NetworkManager.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import Foundation

protocol Networkable {
    func fetchData<T: Decodable>(path: String, completion: @escaping (Result<T, APINetworkError>) -> Void)
}

final class NetworkManager: Networkable {
    
    private let API_KEY = ""

    static var shared = NetworkManager()
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyjson.com"
        return components
    }()
    
    private let session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchData<T: Decodable>(path: String, completion: @escaping (Result<T, APINetworkError>) -> Void) {
        var components = urlComponents
        components.path = path
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.failedGET))
                return
            }
            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                completion(.failure(.httpRequestFailed))
                print("my response is \(String(describing: response))")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
