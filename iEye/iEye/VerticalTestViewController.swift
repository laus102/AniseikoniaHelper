//
//  VerticalTestViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

protocol VerticalTestViewControllerDelegate: class {
    func toHorizontalButtonPressed(inVerticalVC sender: VerticalTestViewController)
    func toDoneButtonPressed(inVerticalVC sender: VerticalTestViewController)
}

class VerticalTestViewController: UIViewController {
    
    
    @IBOutlet weak var leftEyeScaleReadOutLabel: PillLabel!
    @IBOutlet weak var rightEyeScaleReadOutLabel: PillLabel!
    
    @IBOutlet weak var scaleAdjustSlider: UISlider!
        
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var toHorizontalTestButton: PillButton!
    
    @IBOutlet weak var leftDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var rightDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var leftDiagramCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightDiagramCenterXConstraint: NSLayoutConstraint!

    weak var delegate: VerticalTestViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftDiagramComponentView.fillColor = UIColor.iEyeGreen
        rightDiagramComponentView.fillColor = UIColor.iEyeRed
        leftDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        rightDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        leftDiagramCenterXConstraint.constant = 0.5
        rightDiagramCenterXConstraint.constant = 0.5
        leftDiagramComponentView.transform = CGAffineTransform(scaleX: -1, y: 1) // reflect the left diagram across the Y-axis
        
        rightEyeScaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        leftEyeScaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        rightEyeScaleReadOutLabel.layer.borderWidth = 1.5
        leftEyeScaleReadOutLabel.layer.borderWidth = 1.5
        
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi / 2)))
        
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
    
    @IBAction func toHorizontalTestButtonPressed(_ sender: Any) { delegate?.toHorizontalButtonPressed(inVerticalVC: self) }
    @IBAction func testDoneButtonPressed(_ sender: Any) { delegate?.toDoneButtonPressed(inVerticalVC: self) }
    
    // Scale
    
    @IBAction func scaleAdjustSliderValueChanged(_ sender: UISlider) {
        let roundedScaleValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        
        // Adjust the scale of the diagrams
        let percentage = CGFloat(1.0 - abs(roundedScaleValue))
        if (roundedScaleValue >= 0.0) { rightDiagramComponentView.adjust(scale: percentage, diagramOrientation: DiagramDirection.right) }
        if (roundedScaleValue <= 0.0) { leftDiagramComponentView.adjust(scale: percentage, diagramOrientation: DiagramDirection.left) }
        
        // Adjust the read out labels
        leftEyeScaleReadOutLabel.text = (roundedScaleValue >= 0.0) ? "-\( Int((abs(percentage - 1.0)/percentage)*100.0) )%" : "+\( Int((abs(percentage - 1.0)/1.0)*100.0) )%"
        rightEyeScaleReadOutLabel.text = (roundedScaleValue >= 0.0) ? "+\( Int((abs(percentage - 1.0)/1.0)*100.0) )%" : "-\( Int((abs(percentage - 1.0)/percentage)*100.0) )%"
        
        if (roundedScaleValue == 0.0) {
            leftEyeScaleReadOutLabel.text = "100%"
            rightEyeScaleReadOutLabel.text = "100%"
        }
    }
    
}
