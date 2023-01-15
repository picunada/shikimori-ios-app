//
//  ShikimoriAppApp.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/18/22.
//

import SwiftUI

@main
struct ShikimoriAppApp: App {
    @StateObject var appData: AppDataViewModel = .init()
    @StateObject var authData: AuthViewModel = .init()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if !authData.isAuthenticated {
                LoginView()
                    .environmentObject(authData)
            } else {
                ContentView()
                    .environmentObject(appData)
                    .environmentObject(authData)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onOpenURL { url in
                        appData.checkDeepLink(url: url)
                    }
            }
        }
    }
}
