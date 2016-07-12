//
//  MainViewController.swift
//  inflation-calc
//
//  Created by Liam Nickell on 7/8/16.
//  Copyright © 2016 Liam Nickell. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	@IBOutlet weak var infCalcBtn: UIButton!
	@IBOutlet weak var infCalcBtnEuro: UIButton!
	@IBOutlet weak var infForcastCalcBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		infCalcBtn.layer.cornerRadius = 6
		infForcastCalcBtn.layer.cornerRadius = 6
    }
	
	override func viewWillAppear(animated: Bool) {
		navigationController?.navigationBarHidden = true
	}
	
	override func viewWillDisappear(animated: Bool) {
		navigationController?.navigationBarHidden = false
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
