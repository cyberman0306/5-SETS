//
//  PushUpReadyView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/23.
//

import SwiftUI

struct PushUpReadyAndCountView: View {
    @Binding var timeForReady: Int
    @Binding var repsCounts: Int
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 10)
            if timeForReady == 0 {
                //운동 진행중 화면
                HStack {
                    Text(String(repsCounts))
                        .font(.system(size: 90).bold())
                        .foregroundColor(.white)
                        .padding(30)
                    Spacer()
                }
            }
            //레디 시간 보여줌
            if timeForReady > 0 {
                Spacer()
                Text("Ready...")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                Text(String(timeForReady))
                    .font(.system(size: 100).bold())
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        if timeForReady > 0 {
                            if timeForReady < 5 {
                                SoundManager.instance.playSoundForCountdown()
                            }
                            timeForReady -= 1
                        }
                        if timeForReady == 0 {
                            SoundManager.instance.playSoundForCountdown()
                            SoundManager.instance.playSoundStart()
                        }
                    }
            }
            Spacer()
        }
    }
}
//
//struct PushUpReadyView_Previews: PreviewProvider {
//    static var previews: some View {
//        PushUpReadyView()
//    }
//}
