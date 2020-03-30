//
//  TodayViewController.swift
//  StepWidgetWidget
//
//  Created by Leeann Drees on 3/30/20.
//  Copyright © 2020 DetroitLabs. All rights reserved.
//

import UIKit
import NotificationCenter
import StepFramework

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet var stepCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
    }
    
    func updateLabel() {
        HealthDataStore().getTodaysSteps { (stepCount) in
            self.stepCountLabel.text = stepCount
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
