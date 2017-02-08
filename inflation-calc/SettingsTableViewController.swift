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
    
    let defaults = UserDefaults.standard
    
    @IBAction func blackKeyboard(_ sender: AnyObject) {
        defaults.set(darkKeyboard.isOn, forKey: "darkKeyboard")
    }
    
    @IBAction func translucentKeyboardToolbar(_ sender: AnyObject) {
        defaults.set(translucentKeyboardToolbar.isOn, forKey: "translucentKeyboardToolbar")
    }
    
    @IBAction func doneBtnCalculates(_ sender: AnyObject) {
        defaults.set(doneBtnCalculates.isOn, forKey: "doneBtn")
    }
    
    @IBAction func doneBtnForecasts(_ sender: AnyObject) {
        defaults.set(doneBtnForecasts.isOn, forKey: "doneBtnForecasts")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        darkKeyboardLbl.adjustsFontSizeToFitWidth = true
        translucentKeyboardToolbarLbl.adjustsFontSizeToFitWidth = true
        doneBtnCalculatesLbl.adjustsFontSizeToFitWidth = true
        doneBtnForecastsLbl.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.object(forKey: "darkKeyboard") != nil && defaults.object(forKey: "translucentKeyboardToolbar") != nil && defaults.object(forKey: "doneBtn") != nil && defaults.object(forKey: "doneBtnForecasts") != nil {
            darkKeyboard.isOn = defaults.object(forKey: "darkKeyboard") as! Bool
            translucentKeyboardToolbar.isOn = defaults.object(forKey: "translucentKeyboardToolbar") as! Bool
            doneBtnCalculates.isOn = defaults.object(forKey: "doneBtn") as! Bool
            doneBtnForecasts.isOn = defaults.object(forKey: "doneBtnForecasts") as! Bool
        } else {
            defaults.set(darkKeyboard.isOn, forKey: "darkKeyboard")
            defaults.set(translucentKeyboardToolbar.isOn, forKey: "translucentKeyboardToolbar")
            defaults.set(doneBtnCalculates.isOn, forKey: "doneBtn")
            defaults.set(doneBtnForecasts.isOn, forKey: "doneBtnForecasts")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MainViewController
        
        destinationVC.defaults.set(darkKeyboard.isOn, forKey: "darkKeyboard")
        destinationVC.defaults.set(translucentKeyboardToolbar.isOn, forKey: "translucentKeyboardToolbar")
        destinationVC.defaults.set(doneBtnCalculates.isOn, forKey: "doneBtn")
        destinationVC.defaults.set(doneBtnForecasts.isOn, forKey: "doneBtnForecasts")
    }

}