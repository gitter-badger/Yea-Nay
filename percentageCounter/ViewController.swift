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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var percentage : Float = 0
    var fractionNumerator : Float = 0
    var fractionDenominator : Float = 0
    let operationQueue = NSOperationQueue()
    
    class var sharedInstance: ViewController
    {
        struct Static
        {
            static let instance = ViewController()
        }
        return Static.instance
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.operationQueue.maxConcurrentOperationCount = 1
        self.loadState()
        self.updateLabels()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.updateLabels()
    }
    
    @IBAction func voteYes(sender: AnyObject)
    {
        fractionNumerator += 1
        fractionDenominator += 1
        self.updateLabels()
    }
    
    @IBAction func voteNo(sender: AnyObject)
    {
        fractionDenominator += 1
        self.updateLabels()
    }
    
    @IBAction func resetValues(sender: AnyObject)
    {
        self.percentage = 0
        self.fractionNumerator = 0
        self.fractionDenominator = 0
        
        self.updateLabels()
    }
    
    @IBAction func saveStateButtonPressed(sender: AnyObject)
    {
        self.saveState()
    }
    
    func updateLabels ()
    {
        if (self.percentage == 0 && self.fractionDenominator == 0 && self.fractionNumerator == 0)
        {
            self.percentageLabel.text = "0%"
            self.actualFractionLabel.text = "( 0 / 0 )"
        }
        else
        {
            let fraction : Float = self.fractionNumerator / self.fractionDenominator
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
    
    func saveState ()
    {
        self.activityIndicator.startAnimating()
        NSUserDefaults.standardUserDefaults().setObject(self.percentage, forKey: "percentage")
        NSUserDefaults.standardUserDefaults().setObject(self.fractionNumerator, forKey: "numerator")
        NSUserDefaults.standardUserDefaults().setObject(self.fractionDenominator, forKey: "denominator")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.activityIndicator.stopAnimating()
    }
    
    func loadState ()
    {
        if let value = NSUserDefaults.standardUserDefaults().valueForKey("percentage") as? Float
        {
            println("Percentage: \(value)%")
            self.percentage = value
        }
        else
        {
            self.percentage = 0
        }
        if let value = NSUserDefaults.standardUserDefaults().valueForKey("numerator") as? Float
        {
            println("Numerator: \(value).")
            self.fractionNumerator = value
        }
        else
        {
            self.fractionNumerator = 0
        }
        if let value = NSUserDefaults.standardUserDefaults().valueForKey("denominator") as? Float
        {
            println("Denominator: \(value).")
            self.fractionDenominator = value
        }
        else
        {
            self.fractionDenominator = 0
        }
    }
}

