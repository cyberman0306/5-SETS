//
//  PushUpCountingView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/23.
//

import SwiftUI

struct PushUpCountingView: View {
    @Binding var workoutArrayReps: Array<Int>
    @Binding var setsCounts: Int
    var body: some View {
        HStack {
            ForEach(0..<workoutArrayReps.count, id: \.self) { i in
                if i < 5 {
                    if i < setsCounts {
                        Text("\(self.workoutArrayReps[i])")
                            .foregroundColor(.white)
                            .font(.title.bold())
                    } else if  i == setsCounts {
                        Text("\(self.workoutArrayReps[i])")
                            .foregroundColor(.MainColor)
                            .font(.title.bold())
                    } else {
                        Text("\(self.workoutArrayReps[i])")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                }
            }
        }
    }
}
//
//struct PushUpCountingView_Previews: PreviewProvider {
//    static var previews: some View {
//        PushUpInSetView()
//    }
//}
