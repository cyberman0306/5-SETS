//
//  WorkoutLogsView.swift
//  GymHelper
//
//  Created by yook on 2023/03/15.
//

import SwiftUI
import Firebase


struct WorkoutLogsView: View {
    @EnvironmentObject var firestoreData: FirestoreData // firebase log용
    
    @State var workoutArrayReps = workoutData.loadRepArrayTarget()
    @Binding var isAlreadyCheckHelpMenual: Bool
    @AppStorage("log_status") var log_Status = false
    @Binding var GuestMode: Bool
    @State var LogoutalertShowing = false
    @State var email: String = "error"
    @State var LevelArray = workoutData.loadRepLevelTarget()
    
    
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                AdView()
                HStack {
                    Text(LOGTABLocalString)
                        .font(.system(size: 25).bold())
                        .foregroundColor(.ReverseColor)
                    Spacer()
                }.padding()
                
                Spacer()
                VStack{
                    Text("Recent Record")
                        .font(.headline.bold())
                    Text("Level Mode")
                        .font(.headline.bold())
                    Text("\(LevelArray[0]) - \(LevelArray[1]) - \(LevelArray[2]) - \(LevelArray[3]) - \(LevelArray[4])")
                        .font(.body.bold())
                    Text("Custom Mode")
                        .font(.headline.bold())
                    Text("\(workoutArrayReps[0]) - \(workoutArrayReps[1]) - \(workoutArrayReps[2]) - \(workoutArrayReps[3]) - \(workoutArrayReps[4])")
                        .font(.body.bold())
                }
                Spacer()
                Divider()
                if log_Status {
                    ScrollView() {
                        VStack {
                            ForEach(firestoreData.logs, id: \.datestring) { log in
                                HStack {
                                    Text(log.datestring ?? "")
                                        .font(.body.bold())
                                    Spacer()
                                    Text(log.workOutArray.map { String($0 ?? 0) }.joined(separator: " "))
                                        .font(.body.bold())
                                    Spacer()
                                    Text(log.workoutType ?? "")
                                        .font(.body.bold())
                                }
                            }
                        }
                        
                    }.padding()
                }
            }
            .padding()
            .onAppear{
                workoutArrayReps = workoutData.loadRepArrayTarget()
                LevelArray = workoutData.loadRepLevelTarget()
            }
        }
    }
}

