//
//  ForecastingViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/18/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class ForecastingViewController: UIViewController {

	@IBOutlet weak var inputValueTextField: UITextField!
	@IBOutlet weak var annualRateTextField: UITextField!
	@IBOutlet weak var futureYearTextField: UITextField!
	@IBOutlet weak var currencySymbolLbl: UILabel!
	@IBOutlet weak var outputValueLbl: UILabel!
	@IBOutlet weak var calculateBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		outputValueLbl.layer.cornerRadius = 6
		calculateBtn.layer.cornerRadius = 6
		
		outputValueLbl.layer.borderWidth = 1
		outputValueLbl.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

}
