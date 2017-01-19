//
//  StartUpViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/17/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {
   
   @IBOutlet weak private var _titleLabel: UITextField!
   @IBOutlet weak private var _descriptionLabel: UITextField!

   override func viewDidLoad() {
      super.viewDidLoad()
      _descriptionLabel.alpha = 0
      UIView.animate(withDuration: 2.0) {
        self._descriptionLabel.alpha = 1
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
    
}

