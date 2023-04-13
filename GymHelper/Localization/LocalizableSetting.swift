//
//  LocalizableSetting.swift
//  GymHelper
//
//  Created by yook on 2023/04/11.
//
import SwiftUI

let LEVELMODELocalString: LocalizedStringKey = "LEVELMODE"
let CUSTOMMODELocalString: LocalizedStringKey = "CUSTOMMODE"

let PREVIOUSLEVELLocalString: LocalizedStringKey = "PREVIOUSLEVEL"
let NEXTLEVELLocalString: LocalizedStringKey = "NEXTLEVEL"

let Help: LocalizedStringKey = "Help"
let HowToUse: LocalizedStringKey = "HOWTOUSE"
let PUSHUPLocalString: LocalizedStringKey = "PUSHUP"
let LOGTABLocalString: LocalizedStringKey = "LOGTAB"
let SettingLocalString: LocalizedStringKey = "Setting"
let DeleteAccount: LocalizedStringKey = "DeleteAccount"
let LogOut: LocalizedStringKey = "LogOut"
let Setting: LocalizedStringKey = "Setting"

let AwarenessMessage: LocalizedStringKey = "CUSTOM HELP MESSAGE"

let PUSHMESSAGETITLE: LocalizedStringKey = "PUSHMESSAGETITLE"
let PUSHMESSAGEBODY: LocalizedStringKey = "PUSHMESSAGEBODY"

extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.languageCode
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}

extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey!, locale: locale)
    }
}

