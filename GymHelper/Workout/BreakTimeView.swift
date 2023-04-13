//
//  BreakTimeView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/23.
//

import SwiftUI

struct BreakTimeView: View {
    @Binding var setsCounts: Int
    @Binding var BreaktimeTarget: Int
    @Binding var BreaktimeRemaining: Int
    @Binding var repsCounts: Int
    @Binding var issetsDone: Bool
    var body: some View {
        VStack {
            VStack{
                Text("SET")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                    .padding()
                Text("\(setsCounts + 1)")
                    .font(.system(size: 100).bold())
                    .foregroundColor(.white)
                    .padding()
            }.padding(.vertical)
            Spacer()
            VStack{
                Text("BreakTime")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                    .padding()
                Text("\(BreaktimeTarget - BreaktimeRemaining)")
                    .font(.system(size: 100).bold())
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        if BreaktimeTarget > BreaktimeRemaining {
                            if (BreaktimeTarget - BreaktimeRemaining) < 4 {
                                //매번소리나면 시끄러움
                                //SoundManager.instance.playSoundForCountdown()
                            }
                            BreaktimeRemaining += 1
                        }
                        if BreaktimeTarget == BreaktimeRemaining {
                            //현재 갯수 0, 쉬는 시간 타이머 0
                            SoundManager.instance.playSoundReady()
                            repsCounts = 0
                            BreaktimeRemaining = 0
                            issetsDone = false
                        }
                    }.padding()
            }.padding()
            Spacer()
            Button {
                repsCounts = 0
                BreaktimeRemaining = 0
                issetsDone = false
            } label: {
                Text("Next Set")
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
    }
}
