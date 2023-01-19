//
//  HomeView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/18/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var animeViewModel: AnimeViewModel = .init()
    @EnvironmentObject var authData: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                HStack() {
                    Circle()
                        .frame(width: 65, height: 65)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Username")
                            .font(.title2)
                            .bold()
                        Text("Online")
                            .font(.title3)
                    }
                    Spacer()
                }
                .padding(.all, 16)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                
                HStack {
                    Text("Airing now")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                     HStack {
                        ForEach(animeViewModel.animes, id: \.id) { anime in
                            AnimeCellView(viewModel: animeViewModel, anime: anime)
                        }
                    }
                     .padding(.vertical, 20)
                     .padding(.horizontal)
                     .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, -20)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(.all)
                
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("")
        }
        .onAppear {
            animeViewModel.fetchAnimeList(authData.response?.access_token, params: ["page":"1", "limit": "10", "status":"ongoing", "order":"ranked"])
        }
    }
}

