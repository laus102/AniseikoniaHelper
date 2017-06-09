//
//  TestSelectViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

protocol TestSelectViewControllerDelegate: class {
    func toHorizontalButtonPressed(in sender: TestSelectViewController)
    func toVerticalButtonPressed(in sender: TestSelectViewController)
}

class TestSelectViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verticalTestButton: PillButton!
    @IBOutlet weak var horizontalTestButton: PillButton!
    
    // Splash Screen
    @IBOutlet var splashScreen: UIView!
    @IBOutlet weak var splashTitleLabel: UILabel!
    @IBOutlet weak var splashDescriptionLabel: UILabel!
    
    weak var delegate: TestSelectViewControllerDelegate!
    
    /////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Splash Page View
        let temp = NSMutableAttributedString(string: "Welcome to iEye")
        temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(11, 4))
        splashTitleLabel.attributedText = temp
        splashScreen.center = view.center
        splashScreen.backgroundColor = UIColor(r: 255, g: 245, b: 255, a: 1.0)
        DispatchQueue.main.async { UIView.animate(withDuration: 3.0, animations: { self.view.addSubview(self.splashScreen) })
        }
        
        // Test Select VC
        verticalTestButton.layer.borderColor = UIColor.lightGray.cgColor
        verticalTestButton.layer.borderWidth = 1.0
        horizontalTestButton.layer.borderColor = UIColor.lightGray.cgColor
        horizontalTestButton.layer.borderWidth = 1.0
    }
    
    /////////////////////////////////////////////////////////////////////////
    func displayAndDismissSplashScreenWith(DescriptionFadeIn descriptionFadeIn: TimeInterval, splashFadeOut: TimeInterval, testFadeIn: TimeInterval) {
        
        let removeSplashScreen = { (value: Bool) in self.splashScreen.removeFromSuperview() }
        
        let fadeInTestSelectView = { (value: Bool) in UIView.animate(withDuration: testFadeIn,
                                                                     animations: { self.splashScreen.alpha = 0.0 },
                                                                     completion: removeSplashScreen) }
        
        let fadeSplashViewOut = { (value: Bool) in UIView.animate(withDuration: splashFadeOut,
                                                                  animations: { self.splashTitleLabel.alpha = 0.0
                                                                    self.splashDescriptionLabel.alpha = 0.0 },
                                                                  completion: fadeInTestSelectView) }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: descriptionFadeIn,
                           animations: { self.splashDescriptionLabel.alpha = 1 },
                           completion: fadeSplashViewOut) }
    }
    
    /////////////////////////////////////////////////////////////////////////
    
    @IBAction func verticalTestButtonPressed(_ sender: Any) { delegate?.toVerticalButtonPressed(in: self) }
    @IBAction func horizontalTestButtonPressed(_ sender: Any) { delegate?.toHorizontalButtonPressed(in: self) }
    
    
}
