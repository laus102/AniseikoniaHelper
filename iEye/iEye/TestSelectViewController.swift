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
    
    weak var delegate: TestSelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func verticalTestButtonPressed(_ sender: Any) {
//        let verticalTestVC = storyboard!.instantiateViewController(withIdentifier: "VerticalTestViewController") as! VerticalTestViewController
//        present(verticalTestVC, animated: true, completion: nil)
        delegate?.toVerticalButtonPressed(in: self)
    }
    
    @IBAction func horizontalTestButtonPressed(_ sender: Any) {
//        let horizontalTestVC = storyboard!.instantiateViewController(withIdentifier: "HorizontalTestViewController") as! HorizontalTestViewController
//        present(horizontalTestVC, animated: true, completion: nil)
        delegate?.toHorizontalButtonPressed(in: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
}
