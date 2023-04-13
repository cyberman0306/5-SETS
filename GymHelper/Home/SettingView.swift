//
//  SettingView.swift
//  GymHelper
//
//  Created by yook on 2023/03/31.
//

import SwiftUI
import Firebase
import AuthenticationServices

struct SettingView: View {
    @EnvironmentObject var firestoreData: FirestoreData // firebase log용
    @StateObject var loginData = LoginViewModel()
    @State var workoutArrayReps = workoutData.loadRepArrayTarget()
    @State var LogoutalertShowing = false
    @Binding var isAlreadyCheckHelpMenual: Bool
    
    @State var email: String = "error"
    @AppStorage("log_status") var log_Status = false
    
    @State var deleteLogsFailStatus = false
    
    

    @State var isDeleteAccountToggle = false
    @State var LevelArray = workoutData.loadRepLevelTarget()

    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack{
                AdView()
                HStack {
                    Text(Setting)
                        .font(.system(size: 25).bold())
                        .foregroundColor(.ReverseColor)
                    Spacer()
                }.padding()
                if log_Status {
                    VStack(alignment: .leading) {
                        // 로그아웃 버튼
                        Button {
                            LogoutalertShowing = true
                        } label: {
                            HStack {
                                Text(LogOut)
                                    .font(.body.bold())
                                    .padding()
                                    .foregroundColor(Color.ReverseColor)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .alert(isPresented: $LogoutalertShowing) {
                            let firstButton = Alert.Button.destructive(Text("Log out")) {
                                DispatchQueue.global(qos: .background).async {
                                    try? Auth.auth().signOut()
                                }
                                withAnimation(.easeInOut){
                                    log_Status = false
                                    isAlreadyCheckHelpMenual = false
                                }
                            }
                            let secondButton = Alert.Button.cancel(Text("keep going")) {
                                LogoutalertShowing = false
                            }
                            return Alert(title: Text("Are you done?"),
                                         message: Text("Log Out"),
                                         primaryButton: firstButton, secondaryButton: secondButton)
                        }.padding()
                        
                        // 계정 삭제 버튼
                        Button {
                            isDeleteAccountToggle = true
                        } label: {
                            HStack {
                                Text(DeleteAccount)
                                    .font(.body.bold())
                                //                                    .font(.system(size: 20).bold())
                                    .padding()
                                    .foregroundColor(Color.ReverseColor)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .alert(isPresented: $isDeleteAccountToggle) {
                            let firstButton = Alert.Button.destructive(Text("Delete")) {
                                firestoreData.deleteCollection() // 파이어 베이스 지움
                                deleteCurrentUser { success in
                                    if success {
                                        // User was deleted successfully
                                        log_Status = false
                                    } else {
                                        // There was an error deleting the user
                                        print("failed to delete Account")
                                        deleteLogsFailStatus = true
                                    }
                                }
                            }
                            let secondButton = Alert.Button.cancel(Text("Cancel")) {
                                isDeleteAccountToggle = false
                            }
                            return Alert(title: Text("Delete Account"),
                                         message: Text("if you delete account, logs are deleted"),
                                         primaryButton: firstButton, secondaryButton: secondButton)
                        }
                        .alert("Delete Account fail", isPresented: $deleteLogsFailStatus) {
                            // 삭제 실패시 뜨는 경고
                            Button("Log in again before retrying this request.", role: .cancel) {deleteLogsFailStatus = false}
                        }
                        .padding()
                    }
                    Spacer()
                }
                else {
                    Spacer()
                    // 게스트 로그인시 로그인 버튼 보여줌
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
                }
            }
            .padding()
            .onAppear {
                workoutArrayReps = workoutData.loadRepArrayTarget()
                LevelArray = workoutData.loadRepLevelTarget()
                if log_Status {
                    email = accountData.GetAccountInfo()
                }
                
            }
        }
        
    }
}

