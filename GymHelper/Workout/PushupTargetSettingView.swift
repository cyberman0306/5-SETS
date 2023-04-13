//
//  PushupTargetSettingView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/17.
//

import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct PushupTargetSettingView: View {
    
    
    
    
    
    @State var BreaktimeTarget = workoutData.loadBreakTimeTarget()
    @State var workoutArrayReps = workoutData.loadRepArrayTarget()
    @Environment(\.presentationMode) var presentationMode
    
    
    let numbers = Array(0...100)
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            NavigationStack {
                VStack {
                    AdView()
                    Text(CUSTOMMODELocalString)
                        .font(.title.bold())
                        .padding()
                    Spacer()
                    ZStack {
                        Color.gray
                            .opacity(0.15)
                            .cornerRadius(10)
                        //.padding(EdgeInsets(top: 20, leading: 2, bottom: 20, trailing: 2))
                        HStack{
                            VStack{
                                Text("Set 1")
                                Picker("Set 1", selection: $workoutArrayReps[0]) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            VStack{
                                Text("Set 2")
                                Picker("Set 2", selection: $workoutArrayReps[1]) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            VStack{
                                Text("Set 3")
                                Picker("Set 3", selection: $workoutArrayReps[2]) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            VStack{
                                Text("Set 4")
                                Picker("Set 4", selection: $workoutArrayReps[3]) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            VStack{
                                Text("Set 5")
                                Picker("Set 5", selection: $workoutArrayReps[4]) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            VStack{
                                Text("BreakTime")
                                Picker("BreakTime", selection: $BreaktimeTarget) {
                                    ForEach(1 ..< numbers.count, id: \.self) { index in
                                        Text("\(numbers[index])").tag(index)
                                            .font(.title)
                                            .frame(width: 100, height: 100)
                                    }
                                }.pickerStyle(.inline)
                            }
                        }
                    }
                    
                    Spacer()
                    NavigationLink {
                        withAnimation(.easeInOut.delay(3)) {
                            PushupWorkoutView(workoutArrayReps: $workoutArrayReps,
                                              BreaktimeTarget: $BreaktimeTarget)
                        }
                    } label: {
                        Text("PUSH UP")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .background(Color.MainColor)
                            .cornerRadius(10)
                        //.background(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.white, lineWidth: 2))
                    }
                    .padding()
                    
                }
                .padding()
            }
            .onAppear{
                type = .CUSTOM
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


