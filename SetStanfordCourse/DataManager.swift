//
//  DataManager.swift
//  SetStanfordCourse
//
//  Created by Тимур Ярулин on 25.12.2020.
//

import UIKit

class DataManager: UIViewController {
     func convertFromIntToView(card: SetCard) -> (String, UIColor, Int) {
        var symbolString = ""
        var fillСoefficient = 0
        for _ in 0...card.number {
            symbolString += "\(setDictionary[card.symbol]!)"
        }
        
        switch card.fill {
        case 0:
            fillСoefficient = 0
        case 1, 2:
            fillСoefficient = 10
        default:
            print("No coefficent")
        }
        return (symbolString, card.color.getColorFromInt(), fillСoefficient)
    }
    
}

extension Int {
    /// Takes Int from 0 to 2 and returns color(red, green, purple)
    func getColorFromInt() -> UIColor {
        var convertedColor: UIColor!
        switch self {
        case 0:
            convertedColor = .red
        case 1:
            convertedColor = .green
        case 2:
            convertedColor = .purple
        default:
            print("This number does not support converting!")
        }
        return convertedColor
    }
    
    mutating func reduce(by number: Int, before finalNumber: Int) -> Int {
        if self == finalNumber {
            return 0
        }
        self -= number
        return self
    }
}
