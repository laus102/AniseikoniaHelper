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
    
    @IBOutlet weak var orientationToggleSwitch: UISwitch!
    var orientationState: DiagramDirection = .right // declared in UIExtensions.swift
    @IBOutlet weak var orientationReadOutLabel: UILabel!
    
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var toHorizontalTestButton: PillButton!
    
    @IBOutlet weak var leftDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var rightDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var leftDiagramCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightDiagramCenterXConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftDiagramComponentView.fillColor = UIColor.iEyeGreen
        rightDiagramComponentView.fillColor = UIColor.iEyeRed
        leftDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        rightDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        leftDiagramCenterXConstraint.constant = 0.5
        rightDiagramCenterXConstraint.constant = 0.5
        leftDiagramComponentView.transform = CGAffineTransform(scaleX: -1, y: 1) // reflect the left diagram across the Y-axis
        
        scaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        scaleReadOutLabel.layer.borderWidth = 1.5
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat(M_PI_2)))
        
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
    
    // MARK: - IBActions
    
    // Navigation
    
    @IBAction func toHorizontalTestButtonPressed(_ sender: Any) {
        let horizontalTestVC = storyboard!.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
        present(horizontalTestVC, animated: true, completion: nil)
    }
    
    @IBAction func testDoneButtonPressed(_ sender: Any) {
        let testSelectVC = storyboard!.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
        present(testSelectVC, animated: true, completion: nil)
    }
    
    // Scale
    
    @IBAction func scaleAdjustSliderValueChanged(_ sender: UISlider) {
        let roundedValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        scaleReadOutLabel.text = "\(roundedValue)"
        
        switch orientationState {
            case DiagramDirection.left: leftDiagramComponentView.adjust(scale: CGFloat(sender.value), diagramOrientation: orientationState)
            case DiagramDirection.right: rightDiagramComponentView.adjust(scale: CGFloat(sender.value), diagramOrientation: orientationState)
          default: print("Unrecognizable DiagramDirection")
        }
    }
    
    @IBAction func orientationToggleDidSwitch(_ sender: Any) {
        orientationReadOutLabel.text = orientationState.next.rawValue
        orientationState = orientationState.next
    }
    

}
