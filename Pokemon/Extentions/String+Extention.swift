//
//  StringExtention.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-30.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
