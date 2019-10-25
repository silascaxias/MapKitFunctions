//
//  UIImageView.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 25/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
