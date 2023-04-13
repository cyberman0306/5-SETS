//
//  HelpModalView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/16.
//

import SwiftUI
import Firebase

struct HelpModalView: View {
    @Binding var isAlreadyCheckHelpMenual: Bool
    
    var body: some View {
        ZStack{
            BackgroundGradientView()
            VStack{
                Text(HowToUse)
                    .font(.title.bold())
                    .padding()
                Spacer()
                HStack{
                    Image(systemName: "figure.taichi")
                        .font(.system(size: 40))
                        .padding()
                    Image(systemName: "window.shade.closed")
                        .font(.system(size: 20))
                        .padding()
                    
                }
                Text(Help)
                    .font(.body.bold())
                    .frame(width: 320, height: 75)
                Spacer()
                Button {
                    isAlreadyCheckHelpMenual = true
                    helpMenualData.saveIsAlreadyCheckHelpMenual(isAlreadyCheckHelpMenual)
                } label: {
                    Text("OK")
                        .frame(width: 320, height: 50)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .background(Color.MainColor)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
                    .frame(height: 20)
            }
        }
    }
}

