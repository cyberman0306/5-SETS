//
//  LoginView.swift
//  GymHelper
//
//  Created by yook on 2023/03/14.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject var loginData = LoginViewModel()
    @Binding var GuestMode: Bool
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundGradientView()
            VStack{
                Spacer()
                Image("LogoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Spacer()
                SignInWithAppleButton { request in
                    loginData.nonce = randomNonceString()
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = sha256(loginData.nonce)
                } onCompletion: { (result) in
                    switch result {
                    case .success(let user):
                        print("success")
                        
                        //do login with firebase
                        guard let credential = user.credential as?
                                ASAuthorizationAppleIDCredential else {
                            print("error with firebase")
                            return
                        }
                        loginData.authenticate(credentical: credential)
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(height: 55)
                .padding(.horizontal, 30)
                .padding(.bottom)
                
                Button {
                    GuestMode = true
                } label: {
                    Text("Guest Login")
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .font(.headline)
                        .foregroundColor(.MainColor)
                    //.font(.system(size: 20))
                        .background(Color.clear)
                        .background(RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color.MainColor, lineWidth: 1))
                    
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
                
                
            }
        }
    }
}

