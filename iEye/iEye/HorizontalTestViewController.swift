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
    @IBOutlet weak var orientationToggleSwitch: UISwitch!
    @IBOutlet weak var orientationReadOutLabel: UILabel!
    
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var verticalTestButton: PillButton!
    
    @IBOutlet weak var diagramImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diagramImage.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
        scaleReadOutLabel.text = "1.0"
        scaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        scaleReadOutLabel.layer.borderWidth = 1.5
        
        scaleAdjustSlider.maximumValue = 1.0
        scaleAdjustSlider.minimumValue = 0.10
        scaleAdjustSlider.setValue(1.0, animated: true)
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
        orientationToggleSwitch.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        orientationToggleSwitch.setOn(true, animated: true)
        orientationToggleSwitch.onTintColor = UIColor(red: 200.0/255.0, green: 32.0/255, blue: 30.0/255, alpha: 1.0)
        orientationReadOutLabel.textColor = UIColor.black
        orientationReadOutLabel.text = "Top"
        
        verticalTestButton.layer.borderColor = UIColor.lightGray.cgColor
        verticalTestButton.layer.borderWidth = 1.5
        verticalTestButton.contentEdgeInsets.top = 15.0
        verticalTestButton.contentEdgeInsets.bottom = 15.0
        verticalTestButton.contentEdgeInsets.left = 15.0
        verticalTestButton.contentEdgeInsets.right = 15.0
    
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
    }
    
    // MARK: IBActions
    
    @IBAction func toVerticalTestButtonPressed(_ sender: Any) {
        let verticalTestVC = storyboard!.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
        present(verticalTestVC, animated: true, completion: nil)
    }
    
    @IBAction func testDoneButtonPressed(_ sender: Any) {
        let testSelectVC = storyboard!.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        present(testSelectVC, animated: true, completion: nil)
    }
    
    @IBAction func scaleAdjustmentSliderValueChanged(_ sender: UISlider) {
        let roundedValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        scaleReadOutLabel.text = "\(roundedValue)"
    }
    
    @IBAction func orientationToggleDidSwitch(_ sender: UISwitch) {
        orientationReadOutLabel.text = orientationReadOutLabel.text == "Top" ? "Bottom" : "Top"
    }

}
