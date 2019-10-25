//
//  UINavigationController.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 25/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    @IBInspectable var backImageIcon: UIImage = #imageLiteral(resourceName: "back-icon")
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(backImageIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = #colorLiteral(red: 0.8926053643, green: 0.5932921171, blue: 0.3987112045, alpha: 1)
        button.addTarget(self, action: #selector(popViewController(animated:)), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        barItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        barItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewController.navigationItem.leftBarButtonItem = barItem
        viewController.navigationItem.leftBarButtonItem?.tintColor = .white
        
        viewController.navigationItem.rightBarButtonItem?.isEnabled = false
        
        super.pushViewController(viewController, animated: animated)
    }
   
}
