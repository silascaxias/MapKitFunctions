//
//  ImageUitls.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class ImageUtils {
    static func imageWithSize(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
          UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
          image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
          let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          return newImage
      }
}
