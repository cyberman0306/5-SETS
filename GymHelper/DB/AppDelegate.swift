//
//  AppDelegate.swift
//  GymHelper
//
//  Created by yook on 2023/04/08.
//
import SwiftUI
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate{
    
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        scheduleLocalNotification()
        scheduleLocalNotificationLunch()
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        print("토큰을 받았다")
        // Store this token to firebase and retrieve when to send message to someone...
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        // Store token in Firestore For Sending Notifications From Server in Future...
        
        print(dataDict)
        sendTokenToFirebase(fcmToken)
    }
    
    
    func sendTokenToFirebase(_ fcmToken: String?) {
        guard let fcmToken = fcmToken else {
            print("FCM token is nil")
            return
        }
        
        // Get a reference to the Firebase Cloud Firestore database
        let db = Firestore.firestore()
        
        // Get the current user's ID, assuming you have implemented Firebase Authentication
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user is not authenticated")
            return
        }
        
        // Create a document reference for the user's FCM token
        let fcmTokenRef = db.collection("users").document(currentUserID).collection("tokens").document(fcmToken)
        
        // Set the FCM token in the document
        fcmTokenRef.setData(["token": fcmToken]) { error in
            if let error = error {
                print("Error setting FCM token: \(error.localizedDescription)")
            } else {
                print("FCM token set successfully")
            }
        }
    }

}

// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
      
    let userInfo = notification.request.content.userInfo

    
    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
    
    
    print(userInfo)

    completionHandler([[.banner, .badge, .sound]])
  }

    // 푸시메세지를 받았을 떄
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // Do Something With MSG Data...
    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }
      
    print(userInfo)

    completionHandler()
  }
    
    
    // 함수 내부에서 푸시 알람 설정
    func scheduleLocalNotification() {
        
        let currentTimeZone = TimeZone.current
        
        let content = UNMutableNotificationContent()
        
        let title = LocalizedStringKey("PUSHMESSAGETITLE")
        let body = LocalizedStringKey("PUSHMESSAGEBODY")
        content.title = title.stringValue()
        content.body = body.stringValue()
        
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 00
        dateComponents.timeZone = currentTimeZone
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("알림 예약 성공!")
            }
        }
    }

    func scheduleLocalNotificationLunch() {
        
        let currentTimeZone = TimeZone.current
        
        let content = UNMutableNotificationContent()
        
        let title = LocalizedStringKey("PUSHMESSAGETITLE")
        let body = LocalizedStringKey("PUSHMESSAGEBODY")
        content.title = title.stringValue()
        content.body = body.stringValue()
        
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 00
        dateComponents.timeZone = currentTimeZone
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: "scheduleLocalNotificationLunch", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("알림 예약 성공! scheduleLocalNotificationLunch")
            }
        }
    }
}

