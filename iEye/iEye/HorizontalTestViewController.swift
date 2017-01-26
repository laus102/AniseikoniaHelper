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
    var orientationState: DiagramDirection = .top
    @IBOutlet weak var orientationReadOutLabel: UILabel!
    
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var verticalTestButton: PillButton!
    
    @IBOutlet weak var topDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var bottomDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var topDiagramCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomDiagramCenterXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomDiagramComponentView.fillColor = UIColor.iEyeGreen
        topDiagramComponentView.fillColor = UIColor.iEyeRed
        
        bottomDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        topDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomDiagramCenterXConstraint.constant = 0.5
        topDiagramCenterXConstraint.constant = 0.5
        
        bottomDiagramComponentView.transform = CGAffineTransform(scaleX: 1, y: -1) // reflect the bottom diagram across the Y-axis
        
        scaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        scaleReadOutLabel.layer.borderWidth = 1.5
        
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        orientationToggleSwitch.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
                
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

    
    // MARK: IBActions
    
    // Navigation
    
    @IBAction func toVerticalTestButtonPressed(_ sender: Any) {
        let verticalTestVC = storyboard!.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
        present(verticalTestVC, animated: true, completion: nil)
    }
    
    @IBAction func testDoneButtonPressed(_ sender: Any) {
        let testSelectVC = storyboard!.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        present(testSelectVC, animated: true, completion: nil)
    }
    
    // Scale
    
    @IBAction func scaleAdjustmentSliderValueChanged(_ sender: UISlider) {
        let roundedValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        scaleReadOutLabel.text = "\(roundedValue)"
        
        switch orientationState {
            case .bottom: bottomDiagramComponentView.adjust(scale: CGFloat(sender.value), diagramOrientation: orientationState)
            case .top: topDiagramComponentView.adjust(scale: CGFloat(sender.value), diagramOrientation: orientationState)
          default: print("Unrecognizable DiagramDirection")
        }
    }
    
    @IBAction func orientationToggleDidSwitch(_ sender: UISwitch) {
        orientationReadOutLabel.text = orientationState.next.rawValue
        orientationState = orientationState.next
    }

}
