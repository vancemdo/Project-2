//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Van Do on 2/13/17.
//  Copyright © 2017 Van Do. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var metricSwitch: UISwitch!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var calButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action
    
    // Hit calButton, then get the value from heightText and weightText and convert them.
    /*  Severe Thinness < 16.00
        Moderate Thinness 16.00 - 16.99
        Mild Thinness 17.00 - 18.49
        Normal Range 18.50 - 24.99
        Overweight 25.00 - 29.99
        Obese Class I (Moderate) 30.00 - 34.99
        Obese Class II (Severe) 35.00 - 39.99
        Obese Class III (Very Severe) > 39.99  */
    @IBAction func compute_mass(_ sender: UIButton) {
        // Get the input values under type String.
        let height = String(heightText.text!)!
        let weight = String(weightText.text!)!
        
        // If the texts are numeral, calculate.
        if let h = Float(height), let w = Float(weight) {
            var avg = w / (h * h)
            var str = ""

            // If the metric is off, then re-calculate avg (pound / inch^2).
            // pound = kg * 0.453592
            // feet = inch * 12
            // inch = feet * 0.0254
            if !metricSwitch.isOn {
                avg = (w * 0.453592) / (h * 12 * 0.0254 * h * 12 * 0.0254)
            }
            // Compare and give the final result.
            if avg < 16 {
                str = "Severe Thinness"
            }
            else if avg < 17 {
                str = "Moderate Thinness"
            }
            else if avg < 18.5 {
                str = "Mild Thinness"
            }
            else if avg < 25 {
                str = "Normal"
            }
            else if avg < 30 {
                str = "Overweight"
            }
            else if avg < 35 {
                str = "Obese Class I (Moderate)"
            }
            else if avg < 40 {
                str = "Obese Class II (Severe)"
            }
            else {
                str = "Obese Class II (Vey Severe)"
            }
            // Give the final result in label.
            result.text = String(avg) + " " + str
        }
        // Error when inputs are invalid.
        else {
            result.text = "Invalid height and weight value!"
        }
    }
    
    // When switching, make all labels and textfields default.
    @IBAction func metric_switch(_ sender: Any, forEvent event: UIEvent) {
        if metricSwitch.isOn {
            heightLabel.text = "Height (meters)"
            weightLabel.text = "Weight (kgs)"
        }
        else {
            heightLabel.text = "Height (feet)"
            weightLabel.text = "Weight (pounds)"
        }
        result.text = "Enter height and weight."
        heightText.text = ""
        weightText.text = ""
    }
}

