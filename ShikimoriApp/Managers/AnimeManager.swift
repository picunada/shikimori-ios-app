//
//  NetworkManager.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 1/14/23.
//

import Foundation
import Combine

protocol NetworkManager {
    associatedtype Object
    associatedtype Info
    var url: URLComponents { get set }
    
    func fetchList(_ token: String?, params: [String: String]) -> AnyPublisher<[Object], Error>
    func fetchOne(_ token: String?, id: String, params: [String: String]) -> AnyPublisher<Info, Error>
//    func create(_ token: String?, data: Any) -> AnyPublisher<Bool, Error>
//    func update(_ token: String?, data: Any) -> AnyPublisher<Bool, Error>
}

enum NetworkError: Error, LocalizedError {
    case authError
}


class AnimeManager: NetworkManager {
    typealias Object = Anime
    typealias Info = AnimeInfo
    
    var url: URLComponents
    
    init() {
        self.url = URLComponents()
        
        self.url.scheme = "https"
        self.url.host = "shikimori.one"
        self.url.path = "/api/animes"
    }
    
    func fetchList(_ token: String?, params: [String : String]) -> AnyPublisher<[Anime], Error> {
        guard let token = token else {
            return Fail(error: NetworkError.authError).eraseToAnyPublisher()
        }
        
        
        url.path = "/api/animes"
        
        url.queryItems = [URLQueryItem]()

        params.forEach {
            url.queryItems?.append(URLQueryItem(name: $0.0, value: $0.1))
        }
        
        var req = URLRequest(url: url.url!)
        
        req.addValue("Shikimori Pet Project IOS", forHTTPHeaderField: "User-Agent")
        req.addValue("Bearer \(token)", forHTTPHeaderField: "User-Agent")
        
        return URLSession.shared.dataTaskPublisher(for: req)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [Anime].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchOne(_ token: String?, id: String, params: [String : String]) -> AnyPublisher<AnimeInfo, Error> {
        guard let token = token else {
            return Fail(error: NetworkError.authError).eraseToAnyPublisher()
        }
        
        
        url.path = "/api/animes/\(id)"
        
        url.queryItems = [URLQueryItem]()

        params.forEach {
            url.queryItems?.append(URLQueryItem(name: $0.0, value: $0.1))
        }
        
        var req = URLRequest(url: url.url!)
        
        req.addValue("Shikimori Pet Project IOS", forHTTPHeaderField: "User-Agent")
        req.addValue("Bearer \(token)", forHTTPHeaderField: "User-Agent")
        
        return URLSession.shared.dataTaskPublisher(for: req)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: AnimeInfo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
//    
//    func create(_ token: String?, data: Any) -> AnyPublisher<Bool, Error> {
//        <#code#>
//    }
//    
//    func update(_ token: String?, data: Any) -> AnyPublisher<Bool, Error> {
//        <#code#>
//    }
}
