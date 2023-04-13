//
//  ConnectFirebase.swift
//  GymHelper
//
//  Created by yook on 2023/03/15.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

var accountData = AccountData()

class AccountData {
    func GetAccountInfo() -> String {
        var UserEmail = "error"
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                guard let email = user.email else {return "FAIL"}
                print("GetAccountInfo SUCCESS")
                print("email : \(email)")
                UserEmail = email
                
            }
        } else {
            print("GetAccountInfo FAIL")
        }
        return UserEmail
    }
    
    init() {
        //아이디 가져오기 부분
        //데이터 변경 가져오기 부분
    }
    
}

//
//
//class FireStoreManager: ObservableObject {
//    static var shared = FireStoreManager()
//    //DB 컬렉션 이름
//    let DB_ACCOUNT_KEY = "Accounts"
//    let DB_LOG_KEY = "Logs"
//}
