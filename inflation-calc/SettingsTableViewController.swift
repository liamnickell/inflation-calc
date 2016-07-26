//
//  SettingsTableViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/23/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

	@IBOutlet weak var darkKeyboard: UISwitch!
	@IBOutlet weak var translucentKeyboardToolbar: UISwitch!
	@IBOutlet weak var doneBtnCalculates: UISwitch!
	@IBOutlet weak var doneBtnForecasts: UISwitch!
	@IBOutlet weak var darkKeyboardLbl: UILabel!
	@IBOutlet weak var translucentKeyboardToolbarLbl: UILabel!
	@IBOutlet weak var doneBtnCalculatesLbl: UILabel!
	@IBOutlet weak var doneBtnForecastsLbl: UILabel!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	@IBAction func blackKeyboard(sender: AnyObject) {
		defaults.setObject(darkKeyboard.on, forKey: "darkKeyboard")
	}
	
	@IBAction func translucentKeyboardToolbar(sender: AnyObject) {
		defaults.setObject(translucentKeyboardToolbar.on, forKey: "translucentKeyboardToolbar")
	}
	
	@IBAction func doneBtnCalculates(sender: AnyObject) {
		defaults.setObject(doneBtnCalculates.on, forKey: "doneBtn")
	}
	
	@IBAction func doneBtnForecasts(sender: AnyObject) {
		defaults.setObject(doneBtnForecasts.on, forKey: "doneBtnForecasts")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		darkKeyboardLbl.adjustsFontSizeToFitWidth = true
		translucentKeyboardToolbarLbl.adjustsFontSizeToFitWidth = true
		doneBtnCalculatesLbl.adjustsFontSizeToFitWidth = true
		doneBtnForecastsLbl.adjustsFontSizeToFitWidth = true
	}
	
	override func viewWillAppear(animated: Bool) {
		if defaults.objectForKey("darkKeyboard") != nil && defaults.objectForKey("translucentKeyboardToolbar") != nil && defaults.objectForKey("doneBtn") != nil && defaults.objectForKey("doneBtnForecasts") != nil {
			darkKeyboard.on = defaults.objectForKey("darkKeyboard") as! Bool
			translucentKeyboardToolbar.on = defaults.objectForKey("translucentKeyboardToolbar") as! Bool
			doneBtnCalculates.on = defaults.objectForKey("doneBtn") as! Bool
			doneBtnForecasts.on = defaults.objectForKey("doneBtnForecasts") as! Bool
		} else {
			defaults.setObject(darkKeyboard.on, forKey: "darkKeyboard")
			defaults.setObject(translucentKeyboardToolbar.on, forKey: "translucentKeyboardToolbar")
			defaults.setObject(doneBtnCalculates.on, forKey: "doneBtn")
			defaults.setObject(doneBtnForecasts.on, forKey: "doneBtnForecasts")
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let destinationVC = segue.destinationViewController as! MainViewController
		
		destinationVC.defaults.setObject(darkKeyboard.on, forKey: "darkKeyboard")
		destinationVC.defaults.setObject(translucentKeyboardToolbar.on, forKey: "translucentKeyboardToolbar")
		destinationVC.defaults.setObject(doneBtnCalculates.on, forKey: "doneBtn")
		destinationVC.defaults.setObject(doneBtnForecasts.on, forKey: "doneBtnForecasts")
	}

}
