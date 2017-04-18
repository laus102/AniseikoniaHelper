//
//  HorizontalTestViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

protocol HorizontalTestViewControllerDelegate: class {
    func toVerticalButtonPressed(inHorizontalVC sender: HorizontalTestViewController)
    func toDoneButtonPressed(inHorizontalVC sender: HorizontalTestViewController)
}

class HorizontalTestViewController: UIViewController {
    
    @IBOutlet weak var scaleReadOutLabel: PillLabel!
    @IBOutlet weak var scaleAdjustSlider: UISlider!
    
    @IBOutlet weak var testDoneButton: CircleButton!
    @IBOutlet weak var verticalTestButton: PillButton!
    
    @IBOutlet weak var topDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var bottomDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var topDiagramCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomDiagramCenterXConstraint: NSLayoutConstraint!
    
    weak var delegate: HorizontalTestViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomDiagramComponentView.fillColor = UIColor.iEyeRed
        topDiagramComponentView.fillColor = UIColor.iEyeGreen
        
        bottomDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        topDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomDiagramCenterXConstraint.constant = 0.5
        topDiagramCenterXConstraint.constant = 0.5
        
        bottomDiagramComponentView.transform = CGAffineTransform(scaleX: 1, y: -1) // reflect the bottom diagram across the Y-axis
        
        scaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        scaleReadOutLabel.layer.borderWidth = 1.5
        
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi / 2))
                
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
//        let verticalTestVC = storyboard!.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
//        present(verticalTestVC, animated: true, completion: nil)
        delegate?.toVerticalButtonPressed(inHorizontalVC: self)
    }
    
    @IBAction func testDoneButtonPressed(_ sender: Any) {
//        let testSelectVC = storyboard!.instantiateViewController(withIdentifier: "TestSelectViewController") as! TestSelectViewController
//        present(testSelectVC, animated: true, completion: nil)
        delegate?.toDoneButtonPressed(inHorizontalVC: self)
    }
    
    // Scale
    
    @IBAction func scaleAdjustmentSliderValueChanged(_ sender: UISlider) {
        let roundedValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        scaleReadOutLabel.text = "\(roundedValue)"
        
        if (roundedValue >= 0.0) { topDiagramComponentView.adjust(scale: CGFloat(1.0 - roundedValue), diagramOrientation: DiagramDirection.top) }
        if (roundedValue <= 0.0) { bottomDiagramComponentView.adjust(scale: CGFloat(1.0 - abs(roundedValue)), diagramOrientation: DiagramDirection.bottom) }
        
    }
    
}
