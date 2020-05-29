//
//  SecondViewController.swift
//  AddRepairDeleteTable2
//
//  Created by admin on 2/18/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textFieldSecond: UITextField!
    var dataSecond: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dataSecond != nil {
            textFieldSecond.text = dataSecond
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dataSecond = textFieldSecond.text
    }
}
