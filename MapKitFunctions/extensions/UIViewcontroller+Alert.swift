//
//  AlertUtils.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

extension UIViewController {
    func showConfirmAlert(title: String, message: String, preferredStyle: UIAlertController.Style, confirmHandler: (() -> Void)) {
        let confirmAlert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(confirmAlert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style, confirmHandler: @escaping (() -> Void)) {
        let confirmAlert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        confirmAlert.addAction(UIAlertAction(title: "Detalhes", style: .default) { (action:UIAlertAction) in
           confirmHandler()
        })
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(confirmAlert, animated: true, completion: nil)
    }
}
