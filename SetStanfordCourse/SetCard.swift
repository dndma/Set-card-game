//
//  SetCard.swift
//  SetStanfordCourse
//
//  Created by Тимур Ярулин on 19.12.2020.
//

import Foundation

// Describes Set's card.
struct SetCard: Equatable
{
    // Set's card specifications:
    var number: Int  // 0,1,2: count of symbol on card
    var symbol: Int //  0,1,2: triangle, square, circle
    var color: Int //   0,1,2: red, green, purple
    var fill: Int //    0,1,2: fill, strip. empty
    
    var identifier: Int
    
    var isMatched = false
    
    var isRemove = false
}


