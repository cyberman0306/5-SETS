//
//  DataStruct.swift
//  GymHelper
//
//  Created by yook on 2023/03/15.
//


import SwiftUI
import Firebase
var workoutData = WorkOutData()
var type:WorkoutType = .Default

enum WorkoutType {
    case Default
    case LEVEL
    case CUSTOM
    
    var description : String {
      switch self {
      case .Default: return "Default"
      case .LEVEL: return "LEVEL"
      case .CUSTOM: return "CUSTOM"
      }
    }
}

struct WorkOutData {
    private let SET_TARGETKEY = "SET_TARGETKEY"
    private let REP_ARRAY_TARGETKEY = "REP_ARRAY_TARGETKEY"
    private let REP_TARGETKEY = "REP_TARGETKEY"
    private let BreakTimeTARGETKEY = "BreakTimeTARGETKEY"
    private let REP_LEVEL_TARGETKEY = "REP_LEVEL_TARGETKEY"
    
    private var userDefaults = UserDefaults.standard
    
    func saveRecentArrayCUSTOMTarget(_ repArray:Array<Int>, _ breakTime:Int) {
        /**
         CUSTOM MODE의 저장공간에 세트 Array 횟수 저장
         */
        userDefaults.set(repArray, forKey: REP_ARRAY_TARGETKEY)
        userDefaults.set(breakTime, forKey: BreakTimeTARGETKEY)
    }
    
    func saveRecentArrayLEVELTarget(_ repArray:Array<Int>) {
        /**
         LEVEL MODE의 저장공간에 세트 Array 횟수 저장
         */
        userDefaults.set(repArray, forKey: REP_LEVEL_TARGETKEY)
    }
    
    func loadRepArrayTarget() -> Array<Int> {
        guard let repArray: [Int] = userDefaults.object(forKey: REP_ARRAY_TARGETKEY) as? [Int] else {
            return [5, 5, 5, 5, 5]
        }
        return repArray
    }
    
    func loadBreakTimeTarget() -> Int {
        guard let breakTime: Int = userDefaults.object(forKey: BreakTimeTARGETKEY) as? Int else {
            return 30
        }
        return breakTime
    }
    
    func loadRepLevelTarget() -> Array<Int> {
        guard let repArray: [Int] = userDefaults.object(forKey: REP_LEVEL_TARGETKEY) as? [Int] else {
            return [5, 5, 5, 5, 5]
        }
        return repArray
    }
    func NextLevelTargetMaker() -> Array<Int> {
        guard let repArray: [Int] = userDefaults.object(forKey: REP_LEVEL_TARGETKEY) as? [Int] else {
            return [7, 5, 7, 5, 5]
        }
        var tempArray = repArray
        let sum = repArray.reduce(0, +)
        if sum % 2 == 1 {
            tempArray[0] += 1
            tempArray[2] += 1
            tempArray[4] += 1
        } else if tempArray [1] > tempArray[3] {
            tempArray[1] += 1
            
        } else {
            tempArray[3] += 1
        }
        
        print(tempArray)
        return tempArray
    }
}

extension Color {
    static let MainColor = Color("NewColor")
    static let BackgorundColor = Color("BackgorundColor")
    static let ReverseColor = Color("ReverseColor")
}
