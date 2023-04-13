//
//  ContentView.swift
//  GymHelper
//
//  Created by yook on 2023/03/14.
//

import SwiftUI
import Firebase
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var firestoreData: FirestoreData // firebase log용
    
    @AppStorage("log_status") var log_Status = false
    @State var GuestMode = false
    @State var cameraPermissionGranted = false
    @State var isAlreadyCheckHelpMenual = false
    @State var isLoading: Bool = true
    
    
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                if log_Status || GuestMode {
                    TabView {
                        MainPageView(isAlreadyCheckHelpMenual: $isAlreadyCheckHelpMenual, GuestMode: $GuestMode)
                            .tabItem {
                                Image(systemName: "dumbbell.fill")
                                Text(PUSHUPLocalString)
                            }
                        WorkoutLogsView(isAlreadyCheckHelpMenual: $isAlreadyCheckHelpMenual, GuestMode: $GuestMode)
                            .tabItem {
                                Image(systemName: "list.bullet.clipboard.fill")
                                Text(LOGTABLocalString)
                            }
                        SettingView(isAlreadyCheckHelpMenual: $isAlreadyCheckHelpMenual)
                            .tabItem {
                                Image(systemName: "gearshape.fill")
                                Text(SettingLocalString)
                            }
                    }
                    .accentColor(.MainColor)
                } else {
                    LoginView(GuestMode: $GuestMode)
                }
            }
            if isLoading {
                launchScreenView
            }
        }.onAppear {
            AVCaptureDevice.requestAccess(for: .video) { accessGranted in
                DispatchQueue.main.async {
                    self.cameraPermissionGranted = accessGranted
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation(.easeInOut) {
                    isLoading.toggle()
                }
            })
            if log_Status {
                firestoreData.email = accountData.GetAccountInfo()
                firestoreData.fetchData()
            }
            if log_Status == true && GuestMode == true {
                GuestMode = false
                print("로그인 상태인데 게스트모드도 켜져있습니다")
            }
        }
    }
}

extension ContentView {
    var launchScreenView: some View {
        ZStack(alignment: .center) {
            BackgroundGradientView()
            VStack {
                Spacer()
                Image("LogoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Spacer()
                Text("@ HYUN JUN YOOK")
                    .bold()
                    .padding()
                Spacer()
            }
        }
    }
}
