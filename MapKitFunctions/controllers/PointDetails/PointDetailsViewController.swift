//
//  PointDetailsViewController.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 24/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class PointDetailsViewController : UIViewController {
    
    @IBOutlet weak var pointNameLabel: UILabel!
    var pointName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointNameLabel.text = pointName
    }
}
