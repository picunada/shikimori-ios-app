//
//  AnimeInfoView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 1/19/23.
//

import SwiftUI

struct AnimeInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var animeInfo: AnimeInfo
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    LazyVGrid(columns: [.init(alignment: .leading), .init(alignment: .leading)], alignment: .leading) {
                        AsyncImage(url: URL(string: "https://shikimori.one/\(animeInfo.image.original)")) { image in
                            image
                                .resizable()
                                .frame(width: 150, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Information")
                                .font(.title3.bold())
                            
                            HStack(spacing: 0) {
                                Text("Type: ")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(animeInfo.kind.uppercased())
                                    .font(.caption)
                            }
                            HStack(spacing: 0) {
                                Text("Episodes: ")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if animeInfo.episodes > 0 {
                                    Text("\(animeInfo.episodesAired)/\(animeInfo.episodes)")
                                        .font(.caption)
                                } else {
                                    Text("\(animeInfo.episodesAired)")
                                        .font(.caption)
                                }
                                
                            }
                            HStack(spacing: 0) {
                                Text("Episode duration: ")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(animeInfo.duration) min")
                                    .font(.caption)
                            }
                            HStack(spacing: 0) {
                                Text("Status: ")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(animeInfo.status)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(2)
                                    .background(animeInfo.status == "ongoing" ? Color.blue : Color.green)
                                    .cornerRadius(5)
                            }
                            LazyHGrid(rows: [.init(alignment: .leading), .init(alignment: .leading), .init(alignment: .leading), .init(alignment: .leading)], alignment: .top, spacing: 2) {
                                Text("Genres: ")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                ForEach(animeInfo.genres, id: \.id) { genre in
                                    Text("\(genre.name.capitalized)")
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                    LazyVGrid(columns: [.init(alignment: .leading), .init(alignment: .leading)]) {
                        VStack(alignment: .leading) {
                            Text("Studio")
                                .font(.title3.bold())
                            AsyncImage(url: URL(string: "https://shikimori.one/\(animeInfo.studios[0].image)")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 150)
                                    .cornerRadius(5)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            if let rating = Double(animeInfo.score) {
                                Text("Rating")
                                    .font(.title3.bold())
                                
                                HStack(alignment: .center) {
                                    RatingView(rating: rating/2)
                                        .foregroundColor(.blue)
                                    Text(String(format: "%.2f", rating))
                                }
                                .frame(width: 170)
                                
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(height: 170)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if let description = animeInfo.description {
                            Text("Description")
                                .font(.title3.bold())
                            Text(description)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .navigationTitle(animeInfo.name)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


struct AnimeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeInfoView(animeInfo: dev.animeInfo)
    }
}
