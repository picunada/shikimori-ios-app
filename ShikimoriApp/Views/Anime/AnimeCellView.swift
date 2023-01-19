//
//  AnimeCellView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 1/19/23.
//

import SwiftUI

struct AnimeCellView: View {
    
    @ObservedObject var viewModel: AnimeViewModel
    @EnvironmentObject var authData: AuthViewModel
    var anime: Anime
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://shikimori.one/\(anime.image.original)")) { image in
                image.resizable().frame(width: 150, height: 200).aspectRatio(contentMode: .fit).cornerRadius(10)
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
            .cornerRadius(10)
        }
        .onTapGesture {
            print("tapped")
            viewModel.fetchAnimeInfo(authData.response?.access_token, id: String(anime.id), params: ["":""])
        }
        .sheet(item: $viewModel.animeInfo, content: { info in
            AnimeInfoView(animeInfo: info)
                .presentationDragIndicator(.visible)
                .presentationDetents([.large, .medium])
        })
        .frame(width: 150, height: 200)
        .shadow(radius: 7)
    }
}


struct AnimeCellView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCellView(viewModel: dev.animeVM, anime: dev.anime)
            .previewLayout(.sizeThatFits)
    }
}
