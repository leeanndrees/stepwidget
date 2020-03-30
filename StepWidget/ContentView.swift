//
//  ContentView.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/24/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import StepFramework
import SwiftUI

struct ContentView: View {
    @State var stepCount: String = "..."
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "flame")
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                Text(stepCount)
                    .font(.system(size: 50))
            }
                .padding()
            Button(action: authorizeHealthKit) { Text("Authorize HealthKit") }
        }
        .onAppear(perform: loadStepCount)
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
            self.loadStepCount()
        }
    }
    
    func loadStepCount() {
        HealthDataStore().getTodaysSteps { (stepCount) in
            self.stepCount = stepCount
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
