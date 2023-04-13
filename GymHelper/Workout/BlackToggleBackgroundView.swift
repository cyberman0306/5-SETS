//
//  BlackToggleBackgroundView.swift
//  GymHelper
//
//  Created by cnu on 2023/03/23.
//

import SwiftUI

struct BlackToggleBackgroundView: View {
    @Binding var MakeBackgroundLayerBlack: Bool
    @Binding var backgroundLayerOpacity: Double
    var body: some View {
        VStack{
            if MakeBackgroundLayerBlack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(backgroundLayerOpacity)
            } else {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1.0)
            }
        }
        
    }
}

