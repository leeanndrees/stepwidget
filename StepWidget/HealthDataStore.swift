//
//  HealthDataStore.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/25/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import HealthKit

class HealthDataStore {

    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }

        healthStore.execute(query)
    }

}
