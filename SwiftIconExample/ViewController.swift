//
//  ViewController.swift
//  SwiftIconExample
//
//  Created by Eric Yang on 1/8/19.
//  Copyright © 2019 EricYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.iconImageView.image = UIImage.icon("e903", 48, color: .green)
        self.iconLabel.attributedText = String.icon("e915", 48, color: .red)
    }


}

