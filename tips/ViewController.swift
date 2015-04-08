//
//  ViewController.swift
//  tips
//
//  Created by Tunlin Ou on 4/7/15.
//  Copyright (c) 2015 Tunlin Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipPercentageSlider.value = 15
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateValues()
        animateTotal()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onSliderChanged(sender: AnyObject) {
        updateValues()
    }

    @IBAction func onSliderReleased(sender: AnyObject) {
        animateTotal()
    }

    @IBAction func updateValues() {
        var billWithoutDollarSign = billField.text.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var billAmount = NSString(string: billWithoutDollarSign).doubleValue
        var tipPercentage = Double(round(tipPercentageSlider.value) / 100.0)
        var tip = billAmount * tipPercentage
        var total = billAmount + tip

        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

        if (billField.text == "") {
            billField.text = "$"
        }
        tipPercentageLabel.text = String(format: "%.0f%%", tipPercentageSlider.value)
    }

    @IBAction func animateTotal() {
        if (billField.text != "$") {
            self.tipLabel.alpha = 0
            self.totalLabel.alpha = 0
            self.tipLabel.center.x += 20
            self.totalLabel.center.x += 20

            UIView.animateWithDuration(0.3, animations: {
                self.tipLabel.center.x -= 20
                self.tipLabel.alpha = 1;
            })

            UIView.animateWithDuration(0.3, delay: 0.2, options: nil, animations: {
                self.totalLabel.center.x -= 20
                self.totalLabel.alpha = 1;
            }, completion: nil)
        }
    }
}

