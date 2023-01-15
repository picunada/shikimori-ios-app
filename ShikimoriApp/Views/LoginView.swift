//
//  LoginView.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/20/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var authData: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage(named: "Logo")!)
                .resizable()
                .frame(width: 300, height: 60)
                .cornerRadius(15)
                .padding(.bottom, 150)
            
            Text("Wellcome to Shikimori")
                .font(.title)
                .bold()
                .padding(.bottom, -3)
            
            Text("Join our anime database to find what you like.")
                .font(.title3)
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .foregroundColor(.secondary)
            
            Button {
                authData.signIn()
            } label: {
                HStack {
                    Image("Glyph")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Continue with Shikimori")
                         .font(.title2)
                         .foregroundColor(.primary)
                         .colorInvert()
                }
                .padding(.horizontal)
                
            }
            .frame(width: 350)
            .padding(.vertical, 10)
            .background(Color.primary)
            .cornerRadius(40)
            
            Spacer()
        }
        .onReceive(authData.token.publisher, perform: { token in
            print(token)
            Task {
                do {
                    try await authData.retrieveToken(token: token)
                } catch {
                    print(error)
                }
            }
        })
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
