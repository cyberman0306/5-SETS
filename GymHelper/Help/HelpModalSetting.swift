//
//  HelpModalSetting.swift
//  GymHelper
//
//  Created by cnu on 2023/03/16.
//

import SwiftUI

var helpMenualData = HelpMenualData()

struct HelpMenualData {
    private let FIRSTHELPKEYS = "isAlreadyCheckHelpMenual"
    private let userDefaults = UserDefaults.standard
    
    func saveIsAlreadyCheckHelpMenual(_ boolValue: Bool) {
        let saveData = boolValue
        userDefaults.set(saveData, forKey: FIRSTHELPKEYS)
    }
    
    func isAlreadyCheckHelpMenual() -> Bool {
        guard let BoolData = userDefaults.bool(forKey: FIRSTHELPKEYS) as? Bool else {return false}
        return BoolData
    }
}
