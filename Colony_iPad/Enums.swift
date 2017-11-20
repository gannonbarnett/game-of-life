//
//  Enums.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/19/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation

enum EvolveErrors : Error {
    case Colony_Dead, Colony_Stagnant
}

enum ColonyTemplate : String {
    case blank = "Blank", basic = "Basic", glider = "Glider Gun"
}

var templateNames : [String] = ["Blank", "Basic", "Glider Gun"]
