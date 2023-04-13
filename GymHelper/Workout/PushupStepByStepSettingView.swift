//
//  PushupTargetSettingView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/17.
//

import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct PushupStepByStepSettingView: View {
    
    
    @State var BreaktimeTarget = 30
    @State var workoutNowLevelReps = workoutData.loadRepLevelTarget()
    @State var workoutNextLevelReps = workoutData.NextLevelTargetMaker()
    @Environment(\.presentationMode) var presentationMode
    let numbers = Array(0...100)
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            NavigationStack {
                //Spacer()
                VStack {
                    AdView()
                    Text(LEVELMODELocalString)
                        .font(.title.bold())
                        .padding()
                    Spacer()
                    ZStack {
                        Color.gray
                            .opacity(0.15)
                            .cornerRadius(10)
                            .padding()
                        VStack {
                            HStack {
                                Text(PREVIOUSLEVELLocalString)
                                    .font(.headline.bold())
                                    .padding()
                                Spacer()
                            }
                            HStack{
                                ForEach(0..<workoutNowLevelReps.count, id: \.self) { i in
                                    Text("\(self.workoutNowLevelReps[i])")
                                        .font(.system(size: 20).bold())
                                }.padding()
                            }
                            Divider()
                            HStack {
                                Text(NEXTLEVELLocalString)
                                    .font(.headline.bold())
                                    .padding()
                                Spacer()
                            }
                            HStack{
                                ForEach(0..<workoutNextLevelReps.count, id: \.self) { i in
                                    Text("\(self.workoutNextLevelReps[i])")
                                        .font(.system(size: 20).bold())
                                }.padding()
                            }
                        }.padding()
                        
                    }
                    Spacer()
                    VStack {
                        HStack {
                            NavigationLink {
                                withAnimation(.easeInOut.delay(3)) {
                                    PushupWorkoutView(workoutArrayReps: $workoutNowLevelReps,
                                                      BreaktimeTarget: $BreaktimeTarget)
                                }
                            } label: {
                                Text(PREVIOUSLEVELLocalString)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .font(.title3.bold())
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .background(Color.MainColor)
                                    .cornerRadius(10)
                            }
                            .padding()
                            NavigationLink {
                                withAnimation(.easeInOut.delay(3)) {
                                    PushupWorkoutView(workoutArrayReps: $workoutNextLevelReps,
                                                      BreaktimeTarget: $BreaktimeTarget)
                                }
                            } label: {
                                Text(NEXTLEVELLocalString)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .font(.title3.bold())
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .background(Color.MainColor)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                    }
                    
                    
                }
                .padding()
            }
            .onAppear{
                type = .LEVEL
                //나타날때 과거 기록 불러오기
                workoutNowLevelReps = workoutData.loadRepLevelTarget()
                //나타날때 과거 기록 불러와서 다음 목표 생성 ( 저장은 안함 )
                workoutNextLevelReps = workoutData.NextLevelTargetMaker()
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

