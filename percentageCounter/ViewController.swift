//
//  ViewController.swift
//  percentageCounter
//
//  Created by Jacob Hawken on 10/29/14.
//  Copyright (c) 2014 Jacob Hawken. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var actualFractionLabel: UILabel!
    
    var percentage : Float = 0
    var fractionNumerator : Float = 0
    var fractionDenominator : Float = 0
    var wasReset : Bool = true

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateLabels()
    }
    
    @IBAction func voteYes(sender: AnyObject)
    {
        fractionNumerator += 1
        fractionDenominator += 1
        self.wasReset = false
        self.updateLabels()
    }
    
    @IBAction func voteNo(sender: AnyObject)
    {
        fractionDenominator += 1
        self.wasReset = false
        self.updateLabels()
    }
    
    @IBAction func resetValues(sender: AnyObject)
    {
        self.percentage = 0
        self.fractionNumerator = 0
        self.fractionDenominator = 0
        self.wasReset = true
        self.updateLabels()
    }
    
    func updateLabels ()
    {
        let fraction : Float = self.fractionNumerator / self.fractionDenominator
        if wasReset
        {
            self.percentageLabel.text = "0%"
            self.actualFractionLabel.text = "0/0"
        }
        else
        {
            self.percentage = fraction * 100
            self.percentageLabel.text = percentage.description + "%"
            self.actualFractionLabel.text = "( " + self.truncateFloatForString(self.fractionNumerator) + " / " + self.truncateFloatForString(self.fractionDenominator) + " )"
        }
    }
    
    func truncateFloatForString (inputFloat: Float) -> String
    {
        let initialString = inputFloat.description
        let splitString = initialString.componentsSeparatedByString(".")
        let finalString = splitString.first
        return finalString!
    }
}

