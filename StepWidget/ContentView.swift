//
//  ContentView.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/24/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var stepCount: String = ""
    
    var body: some View {
        VStack {
            Button(action: loadStepCount) { Text("Load Step Count") }
            Text(stepCount)
            Button(action: authorizeHealthKit) { Text("Authorize HealthKit") }
        }
    }
    
    func authorizeHealthKit() {
        HealthKitAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print("\(baseMessage)")
                }
                return
            }
            print("HealthKit Authorization Succeeded")
        }
    }
    
    func loadStepCount() {
        HealthDataStore().getTodaysSteps { (stepCountDouble) in
            let stepCountString = String(stepCountDouble)
            self.stepCount = stepCountString
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
