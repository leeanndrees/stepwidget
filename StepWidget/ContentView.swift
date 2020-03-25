//
//  ContentView.swift
//  StepWidget
//
//  Created by Leeann Drees on 3/24/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: authorizeHealthKit) { Text("Authorize HealthKit") }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
