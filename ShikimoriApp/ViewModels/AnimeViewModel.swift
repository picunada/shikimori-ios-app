//
//  AnimeViewModel.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/23/22.
//

import SwiftUI
import Combine

enum AnimeError: Error ,LocalizedError {
    case fetchError
}

class AnimeViewModel: ObservableObject {
    
    @Published var animes = [Anime]()
    @Published var animeInfo: AnimeInfo?
    @Published var apiError: Error?
    
    private let animeManager: AnimeManager = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    
    func fetchAnimeList(_ token: String? ,params: [String: String]) {
        guard let token = token else {
            self.apiError = AnimeError.fetchError
            return
        }
        
        animeManager.fetchList(token, params: params)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.apiError = error
                case .finished: break
                }
            } receiveValue: { animes in
                self.animes = animes
            }
            .store(in: &cancellables)
    }
    
    func fetchAnimeInfo(_ token: String?, id: String ,params: [String: String]) {
        guard let token = token else {
            self.apiError = AnimeError.fetchError
            return
        }
        
        animeManager.fetchOne(token, id: id, params: params)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.apiError = error
                case .finished: break
                }
            } receiveValue: { info in
                self.animeInfo = info
            }
            .store(in: &cancellables)
    }
}
