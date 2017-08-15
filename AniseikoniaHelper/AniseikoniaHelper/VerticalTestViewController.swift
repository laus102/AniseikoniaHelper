//
//  VerticalTestViewController.swift
//  AniseikoniaHelper
//
//  Created by Brendan Lau on 1/26/17.
//  Copyright © 2017 Brendan Lau. All rights reserved.
//

import UIKit

protocol VerticalTestViewControllerDelegate: class {
    func toHorizontalButtonPressed(inVerticalVC sender: VerticalTestViewController)
}

class VerticalTestViewController: UIViewController {

    // Splash Screen
    @IBOutlet var splashView: UIView!
    @IBOutlet weak var splashTitleLabel: UILabel!
    @IBOutlet weak var splashDescriptionLabel: UILabel!

    @IBOutlet weak var leftEyeScaleReadOutLabel: PillLabel!
    @IBOutlet weak var rightEyeScaleReadOutLabel: PillLabel!
    
    @IBOutlet weak var scaleAdjustSlider: UISlider!

    @IBOutlet weak var toHorizontalTestButton: PillButton!
    
    @IBOutlet weak var leftDiagramComponentView: DiagramComponentView!
    @IBOutlet weak var rightDiagramComponentView: DiagramComponentView!
    
    @IBOutlet weak var leftDiagramCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightDiagramCenterXConstraint: NSLayoutConstraint!

    @IBOutlet weak var staticCircle: UIView!

    weak var delegate: VerticalTestViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Splash Page View
        let temp = NSMutableAttributedString(string: "Welcome to Aniseikonia Helper")
        temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(11, 18))
        temp.addAttributes([ NSFontAttributeName: UIFont.systemFont(ofSize: 70) ], range: NSMakeRange(0, temp.mutableString.length))

        splashTitleLabel.attributedText = temp
        splashView.center = view.center
        splashView.backgroundColor = UIColor(r: 255, g: 245, b: 255, a: 1.0)
        DispatchQueue.main.async { UIView.animate(withDuration: 3.0, animations: { self.view.addSubview(self.splashView) }) }

        leftDiagramComponentView.backgroundColor = UIColor.clear
        rightDiagramComponentView.backgroundColor = UIColor.clear
        leftDiagramComponentView.fillColor = UIColor.AHRed
        rightDiagramComponentView.fillColor = UIColor.AHGreen
        
        leftDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        rightDiagramComponentView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        leftDiagramComponentView.transform = CGAffineTransform(scaleX: -1, y: 1) // reflect the left diagram across the Y-axis
        
        rightEyeScaleReadOutLabel.layer.borderColor = UIColor.AHLightGray.cgColor
        leftEyeScaleReadOutLabel.layer.borderColor = UIColor.AHLightGray.cgColor
        rightEyeScaleReadOutLabel.layer.borderWidth = 1.5
        leftEyeScaleReadOutLabel.layer.borderWidth = 1.5

        scaleAdjustSlider.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi / 2)))
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetSlider))
        scaleAdjustSlider.addGestureRecognizer(gestureRecognizer)
        
        toHorizontalTestButton.layer.borderColor = UIColor.AHLightGray.cgColor
        toHorizontalTestButton.layer.borderWidth = 1.5
        toHorizontalTestButton.contentEdgeInsets.top = 15.0
        toHorizontalTestButton.contentEdgeInsets.bottom = 15.0
        toHorizontalTestButton.contentEdgeInsets.left = 15.0
        toHorizontalTestButton.contentEdgeInsets.right = 15.0

        staticCircle.layer.cornerRadius = staticCircle.frame.size.width/2.0
        staticCircle.clipsToBounds = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resetSlider()
    }

    // Navigation

    func displayAndDismissSplashScreenWith(DescriptionFadeIn descriptionFadeIn: TimeInterval, splashFadeOut: TimeInterval, testFadeIn: TimeInterval) {

        let removeSplashScreen = { (value: Bool) in self.splashView.removeFromSuperview() }

        let fadeInVerticalTestView = { (value: Bool) in UIView.animate(withDuration: testFadeIn,
                                                                     animations: { self.splashView.alpha = 0.0 },
                                                                     completion: removeSplashScreen) }

        let fadeSplashViewOut = { (value: Bool) in UIView.animate(withDuration: splashFadeOut,
                                                                  animations: { self.splashTitleLabel.alpha = 0.0
                                                                    self.splashDescriptionLabel.alpha = 0.0 },
                                                                  completion: fadeInVerticalTestView) }

        DispatchQueue.main.async {
            UIView.animate(withDuration: descriptionFadeIn,
                           animations: { self.splashDescriptionLabel.alpha = 1 },
                           completion: fadeSplashViewOut) }
    }

    @IBAction func toHorizontalTestButtonPressed(_ sender: Any) { delegate?.toHorizontalButtonPressed(inVerticalVC: self) }


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
            leftEyeScaleReadOutLabel.text = "0%"
            rightEyeScaleReadOutLabel.text = "0%"
        }
    }
    
    func resetSlider() {
        scaleAdjustSlider.value = 0.0

        leftDiagramComponentView.adjust(scale: 1.0, diagramOrientation: DiagramDirection.left)
        leftEyeScaleReadOutLabel.text = "0%"

        rightDiagramComponentView.adjust(scale: 1.0, diagramOrientation: DiagramDirection.right)
        rightEyeScaleReadOutLabel.text = "0%"
    }
}
