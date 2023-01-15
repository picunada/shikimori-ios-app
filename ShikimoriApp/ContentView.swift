//
//  ContentView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/18/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appData: AppDataViewModel

    var body: some View {
        TabView(selection: $appData.currentTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            DatabaseView()
                .tag(Tab.database)
                .tabItem {
                    Label("Database", systemImage: "tray.full")
                }
            CommunityView()
                .tag(Tab.community)
                .tabItem {
                    Label("Community", systemImage: "person.3")
                }
            MiscellaneousView()
                .tag(Tab.misc)
                .tabItem {
                    Label("Misc", systemImage: "chart.bar.doc.horizontal")
                }
            InformationView()
                .tag(Tab.profile)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
