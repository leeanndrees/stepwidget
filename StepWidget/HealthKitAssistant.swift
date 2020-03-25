//
//  HealthKitAssistant.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/24/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitAssistant {
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            //TODO error handling
            completion(false, nil)
            print("health kit data not available")
            return
        }
        
        guard let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            //TODO error handling
            completion(false, nil)
            print("data type not available")
            return
        }
        
        let healthKitTypesToRead: Set<HKObjectType> = [stepCount]
        
        HKHealthStore().requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
}
