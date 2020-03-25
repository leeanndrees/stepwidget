//
//  HealthDataStore.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/25/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import HealthKit

class HealthDataStore {

    func getTodaysSteps(completion: @escaping (String) -> Void) {
        let healthStore = HKHealthStore()
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion("no steps")
                return
            }
            let rawDouble = sum.doubleValue(for: HKUnit.count())
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 0
            guard let formattedDouble = numberFormatter.string(from: NSNumber(value: rawDouble)) else {
                completion("error")
                return
            }
            completion(formattedDouble)
        }

        healthStore.execute(query)
    }

}
