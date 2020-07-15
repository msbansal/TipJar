//
//  ViewController.swift
//  TipJar
//
//  Created by Mahak Bansal on 7/12/20.
//  Copyright © 2020 Mahak Bansal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var tipField: UITextField!
    
    let app = UserDefaults.standard;
    let tipArray = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()

        
        if let date2 = app.object(forKey: "date") as? Date {
          let diff = Date().timeIntervalSince(date2)
            if(diff<600) {
                let prevAmt = app.integer(forKey: "bill")
                if(prevAmt != 0) {
                    billTextField.text = "$ "+String(prevAmt)
                    calculateTip(bill: Double(prevAmt))
                }
                

            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        [billTextField .becomeFirstResponder()]
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func billOrTipChanged(_ sender: Any) {
        let billString = billTextField.text!
        let range = billString.index(billString.startIndex, offsetBy: 2)...
        let bill = Double(billString[range]) ?? 0
        print("BILLLL")
        print(bill)
        
        print(billString[range])
        calculateTip(bill: bill)
        
        app.set(bill,forKey: "bill")
        let currDate = Date()
        app.set(currDate,forKey: "date")
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 22.0/255.0, green: 185.0/255.0, blue: 177.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 1.0/255.0, green: 80.0/255.0, blue: 129.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func calculateTip(bill: Double) {
        let tip = bill * tipArray[tipPercentage.selectedSegmentIndex]
        let total = bill + tip
        tipField.text = String(format: "$%.2f", tip)
        totalField.text = String(format: "$%.2f", total)
        
    }


}

