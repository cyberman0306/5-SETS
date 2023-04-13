//
//  MainPageView.swift
//  GymHelper
//
//  Created by yook on 2023/03/09.
//

import SwiftUI
import Firebase

struct MainPageView: View {
    @AppStorage("log_status") var log_Status = false
    
    @Binding var isAlreadyCheckHelpMenual: Bool
    @Binding var GuestMode: Bool
    
    @State var email: String = ""
    
    
    
    var body: some View {
        ZStack {
            if isAlreadyCheckHelpMenual == false {
                HelpModalView(isAlreadyCheckHelpMenual: $isAlreadyCheckHelpMenual)
            } else {
                NavigationStack {
                    ZStack{
                        BackgroundGradientView()
                        VStack {
                            AdView()
                            VStack{
                                HStack {
                                    Text("5 SETS")
                                        .font(.system(size: 40).bold())
                                        .foregroundColor(.ReverseColor)
                                    Spacer()
                                }
                                HStack {
                                    Text("Push UP With Ai Coach")
                                        .font(.system(size: 20))
                                        .foregroundColor(.ReverseColor)
                                    Spacer()
                                }
                            }.padding()
                            
                            Spacer()
                            HStack {
                                Text(PUSHUPLocalString)
                                    .font(.system(size: 25).bold())
                                    .foregroundColor(.ReverseColor)
                                Spacer()
                            }.padding()
                            HStack {
                                Text(LEVELMODELocalString)
                                    .fontWeight(.bold)
                                    .foregroundColor(.ReverseColor)
                                    .font(.system(size: 20))
                                Spacer()
                                NavigationLink {
                                    PushupStepByStepSettingView()
                                } label: {
                                    Text("GO")
                                        .frame(width: 100, height: 40)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .background(Color.MainColor)
                                        .cornerRadius(10)
                                }
                            }.padding()
                            Divider()
                            HStack {
                                Text(CUSTOMMODELocalString)
                                    .fontWeight(.bold)
                                    .foregroundColor(.ReverseColor)
                                    .font(.system(size: 20))
                                Spacer()
                                NavigationLink {
                                    PushupTargetSettingView()
                                } label: {
                                    Text("GO")
                                        .frame(width: 100, height: 40)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .background(Color.MainColor)
                                        .cornerRadius(10)
                                }
                            }.padding()
                            
                            Spacer()
                                .frame(height: 15)
                        }
                    }
                    .padding()
                    
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

