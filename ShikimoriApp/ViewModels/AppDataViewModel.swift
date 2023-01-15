//
//  AppDataViewModel.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/19/22.
//

import SwiftUI


class AppDataViewModel: ObservableObject {
    @Published var currentTab: Tab = .home
    
    func checkDeepLink(url: URL) -> Bool {
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        
        if let tab = Tab(rawValue: host) {
            currentTab = tab
        } else {
            return false
        }
        
        
        return true
    }
}

enum Tab: String {
    case home = "home"
    case database = "database"
    case community = "community"
    case misc = "misc"
    case profile = "profile"
}
