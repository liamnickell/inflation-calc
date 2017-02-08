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
	
	let defaults = UserDefaults.standard
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
		
		if defaults.object(forKey: "darkKeyboard") == nil || defaults.object(forKey: "translucentKeyboardToolbar") == nil || defaults.object(forKey: "doneBtn") == nil || defaults.object(forKey: "doneBtnForecasts") == nil {
			defaults.set(false, forKey: "darkKeyboard")
			defaults.set(true, forKey: "translucentKeyboardToolbar")
			defaults.set(false, forKey: "doneBtn")
			defaults.set(false, forKey: "doneBtnForecasts")
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let btn: UIButton = sender as! UIButton
		let tag = btn.tag
		
		if tag != 6 && tag != 7 && tag != 8 {
			let destinationVC: InfCalcViewController = segue.destination as! InfCalcViewController
			
			if tag == 0 {
				destinationVC.title = "USD Inflation"
				destinationVC.path = Bundle.main.path(forResource: "CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1774
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = false
			} else if tag == 1 {
				destinationVC.title = "EUR Inflation"
				destinationVC.path = Bundle.main.path(forResource: "EU-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1996
				destinationVC.currencySymbol = "€"
				destinationVC.reverseFileOrder = true
			} else if tag == 2 {
				destinationVC.title = "GBP Inflation"
				destinationVC.path = Bundle.main.path(forResource: "UK-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "£"
				destinationVC.reverseFileOrder = true
			} else if tag == 3 {
				destinationVC.title = "CAD Inflation"
				destinationVC.path = Bundle.main.path(forResource: "CAD-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = true
			} else if tag == 4 {
				destinationVC.title = "JPY Inflation"
				destinationVC.path = Bundle.main.path(forResource: "Japan-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "¥"
				destinationVC.reverseFileOrder = true
				destinationVC.isYen = true
			} else if tag == 5 {
				destinationVC.title = "MXN Inflation"
				destinationVC.path = Bundle.main.path(forResource: "MEX-CPI-Data", ofType: "txt")
				destinationVC.maxYear = 1948
				destinationVC.currencySymbol = "$"
				destinationVC.reverseFileOrder = true
			}
			
			destinationVC.keyboardIsDark = defaults.object(forKey: "darkKeyboard") as! Bool
			destinationVC.keyboardToolbarIsTranslucent = defaults.object(forKey: "translucentKeyboardToolbar") as! Bool
			destinationVC.doneBtnCalculates = defaults.object(forKey: "doneBtn") as! Bool
		} else if tag == 6 {
			let destinationVC = segue.destination as! ForecastingViewController
			
			destinationVC.keyboardIsDark = defaults.object(forKey: "darkKeyboard") as! Bool
			destinationVC.keyboardToolbarIsTranslucent = defaults.object(forKey: "translucentKeyboardToolbar") as! Bool
			destinationVC.doneBtnForecasts = defaults.object(forKey: "doneBtnForecasts") as! Bool
		}
	}

}
