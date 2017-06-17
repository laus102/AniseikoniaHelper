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
    
    @IBOutlet weak var topScaleReadOutLabel: PillLabel!
    @IBOutlet weak var bottomScaleReadOutLabel: PillLabel!
    
    @IBOutlet weak var scaleAdjustSlider: UISlider!

    @IBOutlet weak var verticalTestButton: PillButton!
    
    @IBOutlet weak var topDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var bottomDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var topDiagramCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomDiagramCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var staticCircle: UIView!

    weak var delegate: HorizontalTestViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        bottomDiagramComponentView.backgroundColor = UIColor.clear
        topDiagramComponentView.backgroundColor = UIColor.clear
        bottomDiagramComponentView.fillColor = UIColor.iEyeRed
        topDiagramComponentView.fillColor = UIColor.iEyeGreen

        bottomDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        topDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)

        bottomDiagramComponentView.transform = CGAffineTransform(scaleX: 1, y: -1) // reflect the bottom diagram across the X-axis
        
        topScaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        topScaleReadOutLabel.layer.borderWidth = 1.5
        bottomScaleReadOutLabel.layer.borderColor = UIColor.lightGray.cgColor
        bottomScaleReadOutLabel.layer.borderWidth = 1.5
        
        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi / 2))
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetSlider))
        scaleAdjustSlider.addGestureRecognizer(gestureRecognizer)
                
        verticalTestButton.layer.borderColor = UIColor.iEyeLightGray.cgColor
        verticalTestButton.layer.borderWidth = 1.5
        verticalTestButton.contentEdgeInsets.top = 15.0
        verticalTestButton.contentEdgeInsets.bottom = 15.0
        verticalTestButton.contentEdgeInsets.left = 15.0
        verticalTestButton.contentEdgeInsets.right = 15.0
        
        staticCircle.layer.cornerRadius = staticCircle.frame.size.width/2.0
        staticCircle.clipsToBounds = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resetSlider()
    }

    // Navigation
    
    @IBAction func toVerticalTestButtonPressed(_ sender: Any) { delegate?.toVerticalButtonPressed(inHorizontalVC: self) }

    // Scale
    
    @IBAction func scaleAdjustmentSliderValueChanged(_ sender: UISlider) {
        let roundedScaleValue = (sender.value * pow(10.0, 2.0)).rounded() / pow(10.0, 2.0)
        
        // Adjust scale of the diagrams
        let percentage = CGFloat(1.0 - abs(roundedScaleValue))
        if (roundedScaleValue >= 0.0) { topDiagramComponentView.adjust(scale: CGFloat(1.0 - roundedScaleValue), diagramOrientation: DiagramDirection.top) }
        if (roundedScaleValue <= 0.0) { bottomDiagramComponentView.adjust(scale: CGFloat(1.0 - abs(roundedScaleValue)), diagramOrientation: DiagramDirection.bottom) }
        
        // Adjust the read out labels
        topScaleReadOutLabel.text = (roundedScaleValue >= 0.0) ? "+\( Int((abs(percentage - 1.0)/1.0)*100.0) )%" : "-\( Int((abs(percentage - 1.0)/percentage)*100.0) )%"
        bottomScaleReadOutLabel.text = (roundedScaleValue >= 0.0) ? "-\( Int((abs(percentage - 1.0)/percentage)*100.0) )%" : "+\( Int((abs(percentage - 1.0)/1.0)*100.0) )%"
        
        if (roundedScaleValue == 0.0) {
            topScaleReadOutLabel.text = "100%"
            bottomScaleReadOutLabel.text = "100%"
        }
    }
    
    func resetSlider() {
        scaleAdjustSlider.value = 0.0

        topDiagramComponentView.adjust(scale: 1.0, diagramOrientation: DiagramDirection.top)
        topScaleReadOutLabel.text = "100%"

        bottomDiagramComponentView.adjust(scale: 1.0, diagramOrientation: DiagramDirection.bottom)
        bottomScaleReadOutLabel.text = "100%"
    }
    
}
