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
	}
	
	override func viewWillDisappear(animated: Bool) {
		navigationController?.navigationBarHidden = false
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let destinationViewController: InfCalcViewController = segue.destinationViewController as! InfCalcViewController
		let btn: UIButton = sender as! UIButton
		
		if btn.tag == 0 {
			destinationViewController.title = "USD Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1774
			destinationViewController.currencySymbol = "$"
			destinationViewController.reverseFileOrder = false
		} else if btn.tag == 1 {
			destinationViewController.title = "Euro Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("EU-CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1996
			destinationViewController.currencySymbol = "€"
			destinationViewController.reverseFileOrder = true
		} else if btn.tag == 2 {
			destinationViewController.title = "GBP Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("UK-CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1948
			destinationViewController.currencySymbol = "£"
			destinationViewController.reverseFileOrder = true
		} else if btn.tag == 3 {
			destinationViewController.title = "CAD Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("CAD-CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1948
			destinationViewController.currencySymbol = "$"
			destinationViewController.reverseFileOrder = true
		} else if btn.tag == 4 {
			destinationViewController.title = "JPY Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("Japan-CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1948
			destinationViewController.currencySymbol = "¥"
			destinationViewController.reverseFileOrder = true
			destinationViewController.isYen = true
		} else if btn.tag == 5 {
			destinationViewController.title = "MXN Inflation"
			destinationViewController.path = NSBundle.mainBundle().pathForResource("MEX-CPI-Data", ofType: "txt")
			destinationViewController.maxYear = 1948
			destinationViewController.currencySymbol = "$"
			destinationViewController.reverseFileOrder = true
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
