//
//  ViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/2/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class InfCalcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var calculationView: UIView!
    @IBOutlet weak var calcBtn: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencySymbolLbl:UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var topPickerView: UIPickerView!
    @IBOutlet weak var bottomPickerView: UIPickerView!
    
    var years = [Int]()
    var topYear = 2016
    var bottomYear = 2016
    var maxYear = 1774
    
    var currencySymbol = ""
    var reverseFileOrder = false
    var isYen = false
    
    var path = Bundle.main.path(forResource: "CPI-Data", ofType: "txt")
    
    var percentChange = 0.0
    var storedTextFieldContent = ""
    
    var keyboardIsDark = false
    var keyboardToolbarIsTranslucent = true
    var doneBtnCalculates = false
    
    let unknownError = UIAlertController(title: "Unknown Error", message: "An unknown error has occured. Please retry or restart the app.", preferredStyle: UIAlertControllerStyle.alert)
    let invalidInput = UIAlertController(title: "Invalid Input", message: "Please input a valid number before attempting to calculate inflation.", preferredStyle: UIAlertControllerStyle.alert)
    
    @IBAction func calculateInflation() {
        findCpiData()
        
        if let textFieldText = inputTextField.text, let textFieldAsDouble = Double(textFieldText) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            numberFormatter.currencySymbol = currencySymbol + " "
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            
            if percentChange > 0.0 {
                if !isYen {
                    let value = textFieldAsDouble + (textFieldAsDouble * percentChange)
                    textLbl.text = numberFormatter.string(from: NSNumber(value: value))
                } else {
                    let value = round(textFieldAsDouble + (textFieldAsDouble * percentChange))
                    numberFormatter.maximumFractionDigits = 0
                    textLbl.text = numberFormatter.string(from: NSNumber(value: value))
                }
            } else {
                percentChange *= -1.0
                
                if round((textFieldAsDouble - (textFieldAsDouble * percentChange)) * 100) / 100 > 0.0 {
                    if !isYen {
                        let value = textFieldAsDouble - (textFieldAsDouble * percentChange)
                        textLbl.text = numberFormatter.string(from: NSNumber(value: value))
                    } else {
                        let value = round(textFieldAsDouble - (textFieldAsDouble * percentChange))
                        numberFormatter.maximumFractionDigits = 0
                        textLbl.text = numberFormatter.string(from: NSNumber(value: value))
                    }
                } else if !isYen {
                    textLbl.text = "0.00"
                } else {
                    textLbl.text = "0"
                }
            }

            UIView.animate(withDuration: 0.4, animations: {
                self.calculationView.backgroundColor = UIColor(red: 0.0/255.0, green: 235.0/255.0, blue: 160.0/255.0, alpha: 1.0)
            })
            
            UIView.animate(withDuration: 0.6, animations: {
                self.calculationView.backgroundColor = UIColor.white
            })
        } else {
            self.present(invalidInput, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculationView.layer.cornerRadius = 6
        calcBtn.layer.cornerRadius = 6
        
        calculationView.layer.borderWidth = 1
        calculationView.layer.borderColor = UIColor.lightGray.cgColor
        
        for i in (maxYear...2016).reversed() {
            years.append(i)
        }
        
        topPickerView.delegate = self
        topPickerView.dataSource = self
        bottomPickerView.delegate = self
        bottomPickerView.dataSource = self
        
        inputTextField.delegate = self
        
        unknownError.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        invalidInput.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        textLbl.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currencySymbolLbl.text = currencySymbol
        
        if keyboardIsDark {
            inputTextField.keyboardAppearance = UIKeyboardAppearance.dark
        } else {
            inputTextField.keyboardAppearance = UIKeyboardAppearance.default
        }
        
        addKeyboardToolbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isYen = false
    }
    
    func findCpiData() {
        do {
            if let pathToFile = path {
                let fileData = try String(contentsOfFile: pathToFile, encoding: String.Encoding.utf8)
                var fileDataByLine: [String]
                
                if reverseFileOrder {
                    fileDataByLine = fileData.components(separatedBy: CharacterSet.newlines).reversed()
                } else {
                    fileDataByLine = fileData.components(separatedBy: CharacterSet.newlines)
                }
            
                if let initialCpi = Double(fileDataByLine[topYear-maxYear]), let finalCpi = Double(fileDataByLine[bottomYear-maxYear]) {
                    percentChange = (finalCpi - initialCpi) / initialCpi
                }
            } else {
                self.present(unknownError, animated: true, completion: nil)
            }
        } catch let error as NSError {
            print("\(error)")
            self.present(unknownError, animated: true, completion: nil)
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
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(InfCalcViewController.doneBtnPressed))
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(InfCalcViewController.cancelBtnPressed))
        
        var items = [UIBarButtonItem]()
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        
        toolbar.items = items
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        inputTextField.inputAccessoryView = toolbar
    }
    
    func doneBtnPressed() {
        if let text = inputTextField.text {
            storedTextFieldContent = text
        }
        
        if doneBtnCalculates {
            calculateInflation()
        }
        
        self.view.endEditing(true)
    }
    
    func cancelBtnPressed() {
        inputTextField.text = storedTextFieldContent
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(years[row])
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == topPickerView {
            topYear = years[row]
        } else if pickerView == bottomPickerView {
            bottomYear = years[row]
        }
    }
}
