//
//  Helper.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-05-06.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static func getAttributedString(boldText: String, myString: String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = NSMutableAttributedString(string:myString)
        attributedString.append(normalText)
        return attributedString
    }
    
    static func getImage(data : Data?) -> UIImage? {
        guard let data = data else {
            return nil
        }
        let image = UIImage(data: data)
        return image
    }
}
