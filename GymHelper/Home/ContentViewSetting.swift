//
//  OldContentView.swift
//  GymHelper
//
//  Created by yook on 2023/03/08.
//

import SwiftUI
import AVFoundation
import Firebase    

extension EnvironmentValues {
    private struct GeometryEnvironmentKey: EnvironmentKey {
        static let defaultValue: CGSize = CGSize(width: 0, height: 0)
    }
    private struct SafeAreaInsetEnvironmentKey: EnvironmentKey {
        static let defaultValue: EdgeInsets = EdgeInsets()
        
    }
    var geometry: CGSize {
        get { self[GeometryEnvironmentKey.self] }
        set { self[GeometryEnvironmentKey.self] = newValue }
    }
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetEnvironmentKey.self] }
        set { self[SafeAreaInsetEnvironmentKey.self] = newValue }
    }
}



