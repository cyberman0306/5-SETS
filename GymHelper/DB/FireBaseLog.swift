//
//  FireBaseLog.swift
//  GymHelper
//
//  Created by yook on 2023/04/06.
//

import Foundation
import Firebase

struct LogArray: Codable {
    var datestring: String?
    var workOutArray: [Int?]
    var workoutType: String?
}


struct LogArrayload: Codable {
    var datestring: Timestamp?
    var workOutArray: [Int?]
    var workoutType: String?
}

class FirestoreData: ObservableObject {
    @Published var logs: [LogArray] = []
    @Published var email: String = ""
    let DB_ACCOUNT_KEY = "Accounts"
    let DB_LOG_KEY = "Logs"
    private var db = Firestore.firestore()
    
    func fetchData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 로그에 초는 안나타나게 수정
        //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        db.collection(DB_ACCOUNT_KEY).document(email).collection(DB_LOG_KEY).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var documents: [LogArray] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let timestamp = data["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let dateString = dateFormatter.string(from: date)
                    let intArray = data["workOutArray"] as! [Int]
                    let string = data["workoutType"] as! String
                    let logArray = LogArray(datestring: dateString, workOutArray: intArray, workoutType: string)
                    documents.append(logArray)
                }
                self.logs = documents
            }
        }
    }
    
    func saveWorkoutData(workOutArray: Array<Int>, workoutType: String) {
        // 운동 후 데이터를 파이어 베이스에 저장합니다
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current  // 지역 시간으로 변경
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDate = dateFormatter.string(from: date)
        
        let array: [String : Any] = ["date" : date, "workOutArray" : workOutArray, "workoutType" : workoutType]
        let db = Firestore.firestore()
        
        db.collection(DB_ACCOUNT_KEY).document(email).collection(DB_LOG_KEY).document(localDate).setData(array, merge: true) { (error) in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document successfully saved!")
            }
        }
    }
    
    func deleteCollection(batchSize: Int = 100) {
        /// firebase date delete
        let db = Firestore.firestore()
        let collectionRef = db.collection(DB_ACCOUNT_KEY).document(email).collection(DB_LOG_KEY)
        let query = collectionRef.order(by: "__name__").limit(to: batchSize)
        
        deleteQueryBatch(query: query, db: db, batchSize: batchSize) { error in
            if let error = error {
                print("Error deleting collection: \(error.localizedDescription)")
            } else {
                print("Collection successfully deleted!")
            }
        }
    }
    
    private func deleteQueryBatch(query: Query, db: Firestore, batchSize: Int, completion: @escaping (Error?) -> Void) {
        query.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                completion(error)
                return
            }
            
            if snapshot.documents.count == 0 {
                completion(nil)
                return
            }
            
            let batch = db.batch()
            snapshot.documents.forEach { batch.deleteDocument($0.reference) }
            batch.commit { (error) in
                if let error = error {
                    completion(error)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.deleteQueryBatch(query: query, db: db, batchSize: batchSize, completion: completion)
                    }
                }
            }
        }
    }
    
    
}

