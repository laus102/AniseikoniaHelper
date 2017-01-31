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
      
      // Splash page View
      splashScreen.alpha = 1.0
      let temp = NSMutableAttributedString(string: "Welcome to iEye")
      temp.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(11, 4))
      splashTitleLabel.attributedText = temp
      splashDescriptionLabel.text = "A better way to diagnose Aniseikonia"
      splashDescriptionLabel.alpha = 0
      view.addSubview(splashScreen)
      
      // Test Select VC
      verticalTestButton.layer.borderColor = UIColor.lightGray.cgColor
      verticalTestButton.layer.borderWidth = 1.0
      verticalTestButton.contentEdgeInsets.top = 15.0
      verticalTestButton.contentEdgeInsets.bottom = 15.0
      verticalTestButton.contentEdgeInsets.left = 15.0
      verticalTestButton.contentEdgeInsets.right = 15.0
      
      horizontalTestButton.layer.borderColor = UIColor.lightGray.cgColor
      horizontalTestButton.layer.borderWidth = 1.0
      horizontalTestButton.contentEdgeInsets.top = 15.0
      horizontalTestButton.contentEdgeInsets.bottom = 15.0
      horizontalTestButton.contentEdgeInsets.left = 15.0
      horizontalTestButton.contentEdgeInsets.right = 15.0
   }
   
   /////////////////////////////////////////////////////////////////////////
   func fadeTextIn(with duration: TimeInterval) {
      DispatchQueue.main.async {
         UIView.animate(withDuration: duration, animations: { self.splashDescriptionLabel.alpha = 1 })
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            UIView.animate(withDuration: 1.5,
                           animations: { self.splashScreen.alpha = 0.0 },
                           completion: { (value: Bool) in self.splashScreen.removeFromSuperview() })
         }
      }
   }
   
   /////////////////////////////////////////////////////////////////////////
   @IBAction func verticalTestButtonPressed(_ sender: Any) {
      delegate?.toVerticalButtonPressed(in: self)
   }
   
   /////////////////////////////////////////////////////////////////////////
   @IBAction func horizontalTestButtonPressed(_ sender: Any) {
      delegate?.toHorizontalButtonPressed(in: self)
   }
   
   /////////////////////////////////////////////////////////////////////////
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   // MARK: - Navigation
   
}
