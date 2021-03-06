//
//  ForecastingViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/18/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class ForecastingViewController: UIViewController {

    @IBOutlet weak var currencyOptions: UISegmentedControl!
    @IBOutlet weak var inputValueTextField: UITextField!
    @IBOutlet weak var annualRateTextField: UITextField!
    @IBOutlet weak var futureYearTextField: UITextField!
    @IBOutlet weak var currencySymbolLbl: UILabel!
    @IBOutlet weak var outputValueLbl: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    
    var value = 0.0
    var rate = 0.0
    var futureYear = 0
    var result = 0.0
    
    let numberFormatter = NumberFormatter()
    var currencySymbol = "$"
    var isYen = false
    
    var keyboardIsDark = false
    var keyboardToolbarIsTranslucent = true
    var doneBtnForecasts = false
    
    var storedTextFieldContentValue = ""
    var storedTextFieldContentRate = ""
    var storedTextFieldContentFutureYear = ""
    
    let invalidInput = UIAlertController(title: "Invalid Input", message: "Please type a valid input into all text fields before attempting to forecast inflation.", preferredStyle: UIAlertControllerStyle.alert)
    let invalidYearInput = UIAlertController(title: "Invalid Input", message: "Please input a year that is greater than the current year in order to forecast inflation.", preferredStyle: UIAlertControllerStyle.alert)
    let unknownError = UIAlertController(title: "Unknown Error", message: "An unknown error has occured. Please retry or restart the app.", preferredStyle: UIAlertControllerStyle.alert)
    
    @IBAction func changeCurrency() {
        switch currencyOptions.selectedSegmentIndex {
        case 0:
            currencySymbol = "$"
            currencySymbolLbl.text = currencySymbol
            isYen = false
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
                print(result)
            }
        case 1:
            currencySymbol = "€"
            currencySymbolLbl.text = currencySymbol
            isYen = false
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            }
        case 2:
            currencySymbol = "£"
            currencySymbolLbl.text = currencySymbol
            isYen = false
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            }
        case 3:
            currencySymbol = "$"
            currencySymbolLbl.text = currencySymbol
            isYen = false
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            }
        case 4:
            currencySymbol = "¥"
            currencySymbolLbl.text = currencySymbol
            isYen = true
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.maximumFractionDigits = 0
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            }
        case 5:
            currencySymbol = "$"
            currencySymbolLbl.text = currencySymbol
            isYen = false
            if outputValueLbl.text != nil && outputValueLbl.text != "" {
                numberFormatter.currencySymbol = currencySymbol + " "
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                
                outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            }
        default:
            self.present(unknownError, animated: true, completion: nil)
        }
    }
    
    @IBAction func forecastInflation() {
        value = 0.0
        rate = 0.0
        futureYear = 0
        result = 0.0
        
        if let valueText = inputValueTextField.text, let valueTextAsDouble = Double(valueText), let rateText = annualRateTextField.text, let rateTextAsDouble = Double(rateText), let yearText = futureYearTextField.text, let yearTextAsInt = Int(yearText) {
            value = valueTextAsDouble
            rate = rateTextAsDouble / 100
            futureYear = yearTextAsInt
            
            makeCalculation()
        } else {
            self.present(invalidInput, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outputValueLbl.adjustsFontSizeToFitWidth = true
        
        outputValueLbl.layer.cornerRadius = 6
        calculateBtn.layer.cornerRadius = 6
        
        outputValueLbl.layer.borderWidth = 1
        outputValueLbl.layer.borderColor = UIColor.lightGray.cgColor
        
        invalidInput.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        invalidYearInput.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        unknownError.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if keyboardIsDark {
            inputValueTextField.keyboardAppearance = UIKeyboardAppearance.dark
            annualRateTextField.keyboardAppearance = UIKeyboardAppearance.dark
            futureYearTextField.keyboardAppearance = UIKeyboardAppearance.dark
        } else {
            inputValueTextField.keyboardAppearance = UIKeyboardAppearance.default
            annualRateTextField.keyboardAppearance = UIKeyboardAppearance.default
            futureYearTextField.keyboardAppearance = UIKeyboardAppearance.default
        }
        addKeyboardToolbar()
    }
    
    func makeCalculation() {
        if futureYear > 2016 {
            result += value
            
            for _ in 2016...futureYear {
                result += value * rate
            }
            
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            numberFormatter.currencySymbol = currencySymbol + " "
            
            if !isYen {
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
            } else {
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.maximumFractionDigits = 0
            }
            
            outputValueLbl.text = numberFormatter.string(from: NSNumber(value: result))
            
            UIView.animate(withDuration: 0.4, animations: {
                self.outputValueLbl.layer.backgroundColor = UIColor(red: 0.0/255.0, green: 235.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor
            })
            
            UIView.animate(withDuration: 0.6, animations: {
                self.outputValueLbl.layer.backgroundColor = UIColor.white.cgColor
            })
        } else {
            self.present(invalidYearInput, animated: true, completion: nil)
        }
    }

    func addKeyboardToolbar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        if keyboardIsDark {
            toolbar.barStyle = UIBarStyle.black
        } else {
            toolbar.barStyle = UIBarStyle.default
        }
        
        if keyboardToolbarIsTranslucent {
            toolbar.isTranslucent = true
        } else {
            toolbar.isTranslucent = false
        }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ForecastingViewController.doneBtnPressedValueTextField))
        var cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ForecastingViewController.cancelBtnPressedValueTextField))
        
        var items = [UIBarButtonItem]()
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        
        toolbar.items = items
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        inputValueTextField.inputAccessoryView = toolbar
        
        done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ForecastingViewController.doneBtnPressedRateTextField))
        cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ForecastingViewController.cancelBtnPressedRateTextField))
        
        items.removeAll()
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        
        annualRateTextField.inputAccessoryView = toolbar
        
        done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ForecastingViewController.doneBtnPressedFutureYearTextField))
        cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ForecastingViewController.cancelBtnPressedFutureYearTextField))
        
        items.removeAll()
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        
        futureYearTextField.inputAccessoryView = toolbar
    }
    
    func doneBtnPressedValueTextField() {
        if let text = inputValueTextField.text {
            storedTextFieldContentValue = text
        }
        
        if doneBtnForecasts {
            forecastInflation()
        }
        
        self.view.endEditing(true)
    }
    
    func cancelBtnPressedValueTextField() {
        inputValueTextField.text = storedTextFieldContentValue
        self.view.endEditing(true)
    }
    
    func doneBtnPressedRateTextField() {
        if let text = annualRateTextField.text {
            storedTextFieldContentRate = text
        }
        
        if doneBtnForecasts {
            forecastInflation()
        }
        
        self.view.endEditing(true)
    }
    
    func cancelBtnPressedRateTextField() {
        annualRateTextField.text = storedTextFieldContentRate
        self.view.endEditing(true)
    }
    
    func doneBtnPressedFutureYearTextField() {
        if let text = futureYearTextField.text {
            storedTextFieldContentFutureYear = text
        }
        
        if doneBtnForecasts {
            forecastInflation()
        }
        
        self.view.endEditing(true)
    }
    
    func cancelBtnPressedFutureYearTextField() {
        futureYearTextField.text = storedTextFieldContentFutureYear
        self.view.endEditing(true)
    }
    
}