//
//  RatingView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 1/19/23.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Double
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(1..<5 + 1) { i in
                StarView(rating: rating, index: Double(i))
            }
        }
    }
}

struct StarView: View {
    
    var rating: Double
    var index: Double
    
    var maskRatio: CGFloat {
           let mask = rating - CGFloat(index)
           
           switch mask {
           case 1...: return 1
           case ..<0: return 0
           default: return mask
           }
       }
    
    var body: some View {
            GeometryReader { star in
                VStack {
                    Spacer()
                    ZStack {
                        Image(systemName: "star.fill")
                            .frame(width: star.size.width)
                            .mask(
                                Rectangle()
                                    .size(
                                        width: star.size.width * self.maskRatio,
                                        height: star.size.height
                                    )
                            )
                        Image(systemName: "star")
                            .scaledToFit()
                    }
                    
                    Spacer()
                }
            }
        }
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            RatingView(rating: 9.2/2)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            RatingView(rating: 9/2)
                .previewLayout(.sizeThatFits)
        }
    }
}
