//
//  WorkOutDoneView.swift
//  GymHelper
//
//  Created by yook on 2023/03/23.
//

import SwiftUI

struct WorkOutDoneView: View {
    @EnvironmentObject var firestoreData: FirestoreData // firebase log용
    @Environment(\.dismiss) private var dismiss
    @Binding var workoutArrayReps: Array<Int>
    @Binding var isWorkoutDone: Bool
    @Binding var BreaktimeTarget: Int
    @AppStorage("log_status") var log_Status = false
    var body: some View {
        ZStack {
            BackgroundGradientView()
            //모든 세트 완료 화면
            withAnimation(.easeInOut.delay(3)) {
                VStack {
                    AdView()
                    Spacer()
                    Text("\(workoutArrayReps[0]) - \(workoutArrayReps[1]) - \(workoutArrayReps[2]) - \(workoutArrayReps[3]) - \(workoutArrayReps[4])")
                        .font(.title)
                        .foregroundColor(Color.ReverseColor)
                        .padding()
                    Text("Done!")
                        .font(.title)
                        .foregroundColor(Color.ReverseColor)
                        .padding()
                    Text("RECORD SAVED")
                        .font(.body)
                        .foregroundColor(Color.ReverseColor)
                        .padding()
                    Spacer()
                    Button {
                        
                        
                        dismiss()
                        type = .Default
                    } label: {
                        Text("OK")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .background(Color.MainColor)
                            .cornerRadius(10)
                        //.background(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.white, lineWidth: 2))
                    }
                    .padding()
                }.navigationBarBackButtonHidden(true)
            }
            .onAppear{
                if type == .LEVEL {
                    //UserDefault 저장
                    workoutData.saveRecentArrayLEVELTarget(workoutArrayReps)
                } else if type == .CUSTOM {
                    //UserDefault 저장
                    workoutData.saveRecentArrayCUSTOMTarget(workoutArrayReps, BreaktimeTarget)
                } else {
                    workoutData.saveRecentArrayCUSTOMTarget(workoutArrayReps, BreaktimeTarget)
                    workoutData.saveRecentArrayLEVELTarget(workoutArrayReps)
                }
                if log_Status {
                    if type == .LEVEL {
                        //firebase 저장
                        firestoreData.saveWorkoutData(workOutArray: workoutArrayReps, workoutType: WorkoutType.LEVEL.description)
                    } else if type == .CUSTOM {
                        firestoreData.saveWorkoutData(workOutArray: workoutArrayReps, workoutType: WorkoutType.CUSTOM.description)
                    }
                    // 새로고침
                    firestoreData.fetchData()
                }
                print("record saved")
            }
        }
    }
}

