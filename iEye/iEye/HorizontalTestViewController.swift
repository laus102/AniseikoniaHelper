//
//  HorizontalTestViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class HorizontalTestViewController: UIViewController {

    
    @IBOutlet weak var scaleReadOutLabel: PillLabel!
    @IBOutlet weak var scaleAdjustSlider: UISlider!
    @IBOutlet weak var orientationReadOutLabel: UILabel!
    @IBOutlet weak var orientationToggleSwitch: UISwitch!
    
    @IBOutlet weak var verticalTestButton: PillButton!
    @IBOutlet weak var testDoneButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scaleReadOutLabel.text = "1.0"
        scaleAdjustSlider.maximumValue = 1.0
        scaleAdjustSlider.minimumValue = 0.0
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
