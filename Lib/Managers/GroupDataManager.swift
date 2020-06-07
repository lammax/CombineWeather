//
//  GroupDataManager.swift
//  CombineWeather
//
//  Created by Mac on 01.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

class GroupDataManager {
    
    static let shared = GroupDataManager()
    let sharedDefaults = UserDefaults(suiteName: "group.lweather")
  
    func saveData(value: Any, key: String) {
        sharedDefaults?.setValue(value, forKey: key)
    }
    
    func retrieveData(key: String) -> Any? {
        return sharedDefaults?.value(forKey: key)
    }
    
    func removeData(key: String) {
        sharedDefaults?.removeObject(forKey: key)
    }
}
