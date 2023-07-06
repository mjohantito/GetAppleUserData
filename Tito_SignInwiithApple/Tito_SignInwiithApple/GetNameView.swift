//
//  GetNameView.swift
//  Tito_SignInwiithApple
//
//  Created by Manuel Johan Tito on 06/07/23.
//

import AuthenticationServices
import SwiftUI

struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential){
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else {return nil}
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}


struct GetNameView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        SignInWithAppleButton(.signIn,
                              onRequest: configure,
                              onCompletion: handle)
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 45)
            .padding()
    }
    
    func configure(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
//        request.nonce = ""
        
    }
    func handle(_ authResult: Result<ASAuthorization, Error>){
        switch authResult {
        case .success(let auth):
            print(auth)
            switch auth.credential {
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredentials),
                   let appleUserData = try? JSONEncoder().encode(appleUser) {
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                    
                    print("saved apple user", appleUser)
                }
                
            default:
                print(auth.credential)
            }
        case . failure(let error):
            print(error)
        }
    }
}

struct GetNameView_Previews: PreviewProvider {
    static var previews: some View {
        GetNameView()
    }
}
