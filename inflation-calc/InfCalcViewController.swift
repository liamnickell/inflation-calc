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
	
	var path = NSBundle.mainBundle().pathForResource("CPI-Data", ofType: "txt")
	
	var percentChange = 0.0
	var storedTextFieldContent = ""
	
	let unknownError = UIAlertController(title: "Unknown Error", message: "An unknown error has occured. Please retry or restart the app.", preferredStyle: UIAlertControllerStyle.Alert)
	let invalidInput = UIAlertController(title: "Invalid Input", message: "Please input a valid number before attempting to calculate inflation.", preferredStyle: UIAlertControllerStyle.Alert)
	
	@IBAction func calculateInflation(sender: AnyObject) {
		findCpiData()
		
		if let textFieldText = inputTextField.text, textFieldAsDouble = Double(textFieldText) {
			if percentChange > 0.0 {
				if !isYen {
					let value = textFieldAsDouble + (textFieldAsDouble * percentChange)
					textLbl.text = String(format: "%.2f", value)
				} else {
					let value = round(textFieldAsDouble + (textFieldAsDouble * percentChange))
					textLbl.text = String(Int(value))
				}
			} else {
				percentChange *= -1.0
				
				if round((textFieldAsDouble - (textFieldAsDouble * percentChange)) * 100) / 100 > 0.0 {
					if !isYen {
						let value = textFieldAsDouble - (textFieldAsDouble * percentChange)
						textLbl.text = String(format: "%.2f", value)
					} else {
						let value = round(textFieldAsDouble - (textFieldAsDouble * percentChange))
						textLbl.text = String(Int(value))
					}
				} else {
					textLbl.text = "0.00"
				}
			}
			
			addCurrencyModifier(textLbl.text)
			
			UIView.animateWithDuration(0.4, animations: {
				self.calculationView.backgroundColor = UIColor(red: 0.0/255.0, green: 235.0/255.0, blue: 160.0/255.0, alpha: 1.0)
			})
			
			UIView.animateWithDuration(0.6, animations: {
				self.calculationView.backgroundColor = UIColor.whiteColor()
			})
		} else {
			self.presentViewController(invalidInput, animated: true, completion: nil)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		calculationView.layer.cornerRadius = 6
		calcBtn.layer.cornerRadius = 6
		
		calculationView.layer.borderWidth = 1
		calculationView.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		for i in (maxYear...2016).reverse() {
			years.append(i)
		}
		
		topPickerView.delegate = self
		topPickerView.dataSource = self
		bottomPickerView.delegate = self
		bottomPickerView.dataSource = self
		
		inputTextField.delegate = self
		addDoneButtonOnKeyboard()
		
		unknownError.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
		invalidInput.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
		
		textLbl.adjustsFontSizeToFitWidth = true
	}
	
	override func viewWillAppear(animated: Bool) {
		currencySymbolLbl.text = currencySymbol
	}
	
	override func viewWillDisappear(animated: Bool) {
		isYen = false
	}
	
	func findCpiData() {
		do {
			if let pathToFile = path {
				let fileData = try String(contentsOfFile: pathToFile, encoding: NSUTF8StringEncoding)
				var fileDataByLine: [String]
				
				if reverseFileOrder {
					fileDataByLine = fileData.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()).reverse()
				} else {
					fileDataByLine = fileData.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
				}
			
				if let initialCpi = Double(fileDataByLine[topYear-maxYear]), finalCpi = Double(fileDataByLine[bottomYear-maxYear]) {
					percentChange = (finalCpi - initialCpi) / initialCpi
				}
			} else {
				self.presentViewController(unknownError, animated: true, completion: nil)
			}
		} catch let error as NSError {
			print("\(error)")
			self.presentViewController(unknownError, animated: true, completion: nil)
		}
	}
	
	func addCurrencyModifier(textLabel: String?) {
		if let text = textLabel {
			textLbl.text = currencySymbol + " " + text
		}
	}
	
	func addDoneButtonOnKeyboard() {
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
		doneToolbar.barStyle = UIBarStyle.BlackOpaque
		doneToolbar.translucent = true
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
		let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneBtnPressed"))
		let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnPressed")
		
		var items = [UIBarButtonItem]()
		items.append(cancel)
		items.append(flexSpace)
		items.append(done)
		
		doneToolbar.items = items
		doneToolbar.userInteractionEnabled = true
		doneToolbar.sizeToFit()
		
		inputTextField.inputAccessoryView = doneToolbar
	}
	
	func doneBtnPressed() {
		if let text = inputTextField.text {
			storedTextFieldContent = text
		}
		
		inputTextField.resignFirstResponder()
	}
	
	func cancelBtnPressed() {
		inputTextField.text = storedTextFieldContent
		inputTextField.resignFirstResponder()
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return years.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(years[row])
	}
 
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView == topPickerView {
			topYear = years[row]
		} else if pickerView == bottomPickerView {
			bottomYear = years[row]
		}
	}
}