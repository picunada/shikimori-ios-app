//
//  AuthViewModel.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/19/22.
//

import SwiftUI
import AuthenticationServices
import Combine

public struct AuthResponse: Codable {
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var refresh_token: String?
    var scope: String?
    var created_at: Int64?
}

class AuthViewModel: NSObject ,ObservableObject, ASWebAuthenticationPresentationContextProviding {
    
    @Published var token: String?
    @Published var response: AuthResponse?
    @Published var isAuthenticated: Bool = false
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return ASPresentationAnchor()
        }
    
    static func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }
    
    func signIn() {
        let authUrl: URL = URL(string: "https://shikimori.one/oauth/authorize?client_id=xXcqLUB864IwnInxqvOyujb3y4x7QMBAjT6Eqy5VMRc&redirect_uri=shikiapp%3A%2F%2F&response_type=code&scope=user_rates+comments+topics")!
        let scheme = "shikiapp"
        
        let authSession = ASWebAuthenticationSession(
            url: authUrl, callbackURLScheme: scheme) { (callbackURL, error) in
                if let error = error {
                    print(error)
                }
                
                guard let callbackURL = callbackURL else { return }

                // The callback URL format depends on the provider. For this example:
                //   exampleauth://auth?token=1234
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                let token = queryItems?.filter({ $0.name == "code" }).first?.value
                self.token = token
        }
        
        authSession.presentationContextProvider = self
//        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
        }
    
    @MainActor
    func retrieveToken(token: String) async throws {
        guard let url = URL(string: "https://shikimori.one/oauth/token") else {
            throw URLError(URLError.Code(rawValue: 500))
        }
        
        let form = [
            "grant_type": "authorization_code",
            "client_id": "xXcqLUB864IwnInxqvOyujb3y4x7QMBAjT6Eqy5VMRc",
            "client_secret": "1BecyfprlulQI6-sgwfqEb4A_trnSzZKaZSJmIQ11go",
            "code": "\(token)",
            "redirect_uri": "shikiapp://"
        ]
        
        let formData = AuthViewModel.getPostString(params: form)
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        
        req.addValue("Shikimori Pet Project IOS", forHTTPHeaderField: "User-Agent")
        req.httpBody = formData.data(using: .utf8)
        
        let (data, _) = try await URLSession.shared.data(for: req)
        
        
        print(String(data: data, encoding: .utf8)!)
        
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        if response.access_token != nil {
            self.isAuthenticated = true
        }
        self.response = response
    }
    
    @MainActor
    func refreshToken(token: String) async throws {
        guard let url = URL(string: "https://shikimori.one/oauth/token") else {
            throw URLError(URLError.Code(rawValue: 500))
        }
        
        if let response = self.response {
            let form = [
                "grant_type": "refresh_token",
                "client_id": "xXcqLUB864IwnInxqvOyujb3y4x7QMBAjT6Eqy5VMRc",
                "client_secret": "1BecyfprlulQI6-sgwfqEb4A_trnSzZKaZSJmIQ11go",
                "refresh_token": "\(String(describing: response.refresh_token))"
            ]
            
            let formData = AuthViewModel.getPostString(params: form)
            
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            
            req.addValue("Shikimori Pet Project IOS", forHTTPHeaderField: "User-Agent")
            req.httpBody = formData.data(using: .utf8)
            
            let (data, _) = try await URLSession.shared.data(for: req)
            
            let response = try JSONDecoder().decode(AuthResponse.self, from: data)
            if response.access_token != nil {
                self.isAuthenticated = true
            }
            self.response = response
        }
    }
}
