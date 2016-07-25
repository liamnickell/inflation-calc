//
//  MainViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/8/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	@IBOutlet weak var appTitle: UILabel!
	@IBOutlet weak var infCalcBtn: UIButton!
	@IBOutlet weak var infCalcBtnEuro: UIButton!
	@IBOutlet weak var infCalcBtnGpb: UIButton!
	@IBOutlet weak var infCalcBtnJpy: UIButton!
	@IBOutlet weak var infCalcBtnCad: UIButton!
	@IBOutlet weak var infCalcBtnMxn: UIButton!
	@IBOutlet weak var infForecastCalcBtn: UIButton!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		infCalcBtn.layer.cornerRadius = 6
		infForecastCalcBtn.layer.cornerRadius = 6
		infCalcBtnEuro.layer.cornerRadius = 6
		infCalcBtnGpb.layer.cornerRadius = 6
		infCalcBtnJpy.layer.cornerRadius = 6
		infCalcBtnCad.layer.cornerRadius = 6
		infCalcBtnMxn.layer.cornerRadius = 6
		
		appTitle.adjustsFontSizeToFitWidth = true
	}
	
	override func viewWillAppear(animated: Bool) {
		navigationController?.navigationBarHidden = true
		
		if defaults.objectForKey("darkKeyboard") != nil && defaults.objectForKey("translucentKeyboardToolbar") != nil && defaults.objectForKey("doneBtn") == nil {
			defaults.setObject(false, forKey: "darkKeyboard")
			defaults.setObject(true, forKey: "translucentKeyboardToolbar")
			defaults.setObject(false, forKey: "doneBtn")
		}
	}
	
	override func viewWillDisappear(animated: Bool) {
		navigationController?.navigationBarHidden = false
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let btn: UIButton = sender as! UIButton
		let tag = btn.tag
		
		if tag != 6 && tag != 7 && tag != 8 {
			let destinationVC: InfCalcViewController = segue.destinationViewController as! InfCalcViewController
			
			if tag == 0 {
				destinationVC.title = "USD Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1774
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = false
			} else if tag == 1 {
				destinationVC.title = "EUR Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("EU-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1996
				destinationVC.currencySymbol = "€"
				destinationVC.reverseFileOrder = true
			} else if tag == 2 {
				destinationVC.title = "GBP Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("UK-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "£"
				destinationVC.reverseFileOrder = true
			} else if tag == 3 {
				destinationVC.title = "CAD Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("CAD-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = true
			} else if tag == 4 {
				destinationVC.title = "JPY Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("Japan-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "¥"
				destinationVC.reverseFileOrder = true
				destinationVC.isYen = true
			} else if tag == 5 {
				destinationVC.title = "MXN Inflation"
				destinationVC.path = NSBundle.mainBundle().pathForResource("MEX-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = true
			}
			
			destinationVC.keyboardIsDark = defaults.objectForKey("darkKeyboard") as! Bool
			destinationVC.keyboardToolbarIsTranslucent = defaults.objectForKey("translucentKeyboardToolbar") as! Bool
			destinationVC.doneBtnCalculates = defaults.objectForKey("doneBtn") as! Bool
		}
	}

}