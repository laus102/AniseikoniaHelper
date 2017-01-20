//
//  TestSelectViewController.swift
//  iEye
//
//  Created by Brendan Lau on 1/18/17.
//  Copyright © 2017 Incipia. All rights reserved.
//

import UIKit

class TestSelectViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verticalTestButton: PillButton!
    @IBOutlet weak var horizontalTestButton: PillButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verticalTestButton.layer.borderColor = UIColor.black.cgColor
        verticalTestButton.layer.borderWidth = 1.0
        verticalTestButton.contentEdgeInsets.top = 15.0
        verticalTestButton.contentEdgeInsets.bottom = 15.0
        verticalTestButton.contentEdgeInsets.left = 15.0
        verticalTestButton.contentEdgeInsets.right = 15.0
        
        horizontalTestButton.layer.borderColor = UIColor.black.cgColor
        horizontalTestButton.layer.borderWidth = 1.0
        horizontalTestButton.contentEdgeInsets.top = 15.0
        horizontalTestButton.contentEdgeInsets.bottom = 15.0
        horizontalTestButton.contentEdgeInsets.left = 15.0
        horizontalTestButton.contentEdgeInsets.right = 15.0
    
    }
    
    @IBAction func verticalTestButtonPressed(_ sender: Any) {
    }
    
    @IBAction func horizontalTestButtonPressed(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
