//
//  String+CapitalizeFirstLetter.swift
//  WeatherNow
//
//  Created by Vahram Tadevosian on 6/13/20.
//  Copyright © 2020 Vahram Tadevosian. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
