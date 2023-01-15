//
//  HomeView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/18/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var animeApi: AnimeViewModel = .init()
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
                .background(Color(uiColor: .secondarySystemFill))
                .cornerRadius(10)
                
                HStack {
                    Text("Airing now")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                     HStack {
                        ForEach(animeApi.animes, id: \.id) { anime in
                            AnimeCell(anime: anime)
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
            animeApi.fetchAnimeList(authData.response?.access_token, params: ["page":"1", "limit": "10", "status":"ongoing", "order":"ranked"])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AnimeCell: View {
    
    var anime: Anime
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://shikimori.one/\(anime.image.original)")) { image in
                image.resizable().cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            
            
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("\(anime.name)")
                                .font(.caption)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        HStack(alignment: .center ,spacing: 0){
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .padding(.trailing, 3)
                            
                            Text("\(anime.score)")
                                .font(.caption2)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.linearGradient(Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .center))
            .cornerRadius(20)
        }
        .frame(width: 150, height: 200)
        .shadow(radius: 7)
    }
}
