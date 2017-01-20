//
//  VerticalTestViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class VerticalTestViewController: UIViewController {

    
    @IBOutlet weak var scaleReadOutLabel: PillLabel!
    @IBOutlet weak var scaleAdjustSlider: UISlider!
    @IBOutlet weak var rightLeftToggle: UISwitch!
    @IBOutlet weak var orientationReadOutLabel: UILabel!
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var toHorizontalTestButton: PillButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scaleReadOutLabel.text = "1.0"
        scaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        scaleReadOutLabel.layer.borderWidth = 1.5
        
        
        scaleAdjustSlider.maximumValue = 1.0
        scaleAdjustSlider.minimumValue = 0.0
        scaleAdjustSlider.setValue(1.0, animated: true)
        
        rightLeftToggle.setOn(true, animated: true)
        orientationReadOutLabel.textColor = UIColor.black
        orientationReadOutLabel.text = "Right"
        
        toHorizontalTestButton.layer.borderColor = UIColor.lightGray.cgColor
        toHorizontalTestButton.layer.borderWidth = 1.5
        toHorizontalTestButton.contentEdgeInsets.top = 15.0
        toHorizontalTestButton.contentEdgeInsets.bottom = 15.0
        toHorizontalTestButton.contentEdgeInsets.left = 15.0
        toHorizontalTestButton.contentEdgeInsets.right = 15.0
        
        testDoneButton.layer.borderColor = UIColor.lightGray.cgColor
        testDoneButton.layer.borderWidth = 1.5
        testDoneButton.contentEdgeInsets.top = 30.0
        testDoneButton.contentEdgeInsets.bottom = 30.0
        let offset = (testDoneButton.frame.width - testDoneButton.frame.height)
        testDoneButton.contentEdgeInsets.left = 30.0 - offset
        testDoneButton.contentEdgeInsets.right = 30.0 - offset
        
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
