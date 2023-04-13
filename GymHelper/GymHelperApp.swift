//
//  GymHelperApp.swift
//  GymHelper
//
//  Created by yook on 2023/03/08.
//

import SwiftUI
import Firebase
import FirebaseCore
import AVFoundation
import GoogleMobileAds
import AppTrackingTransparency
import FirebaseMessaging
import UserNotifications

@main
struct GymHelperApp: App {
    @StateObject var firestoreData = FirestoreData()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        //DispatchQueue 이용
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreData)
        }
    }
}



