//
//  Set.swift
//  SetStanfordCourse
//
//  Created by Тимур Ярулин on 19.12.2020.
//

import Foundation

// The model of current app
class SetGame
{
    // Stores all game cards
    private(set) var setCards = [SetCard]()
    
    // Contais 3 choosen cards
    private var choosenCards = [SetCard]()
    
    // Checks if three chosen cards are set
    private var possibleSet = [Int]()
    
    private let deck = 81
    
    private(set) var score = 0
    
    ///Chooses card at index.
    func chooseCard(at index: Int) {
        if !setCards[index].isMatched {
            backAllCards()
            setCards[index].isMatched = true
            let card = setCards[index].identifier.convertToTernary()
            if !choosenCards.contains(setCards[index]) {
                choosenCards.append(setCards[index])
                possibleSet += card
            }
            if choosenCards.count == 4 {
                possibleSet.removeLast(4)
                if possibleSet.checkIfSet() {
                    score += 3
                    print("set")
                    for removeIndex in 0...choosenCards.count - 2 {
                        if let cardToRemove = setCards.firstIndex(of:choosenCards[removeIndex]) {
                            setCards[cardToRemove].isRemove = true
                        } else { fatalError("Error while checking cards!") }
                    }
                } else if score > 0 {
                    score -= 1
                }
                choosenCards.removeAll()
                possibleSet.removeAll()
                for index in 0...setCards.count - 1 {
                    setCards[index].isMatched = false
                }
            }
        } else {
            setCards[index].isMatched = false
            if let chosenCardToRemove = choosenCards.firstIndex(of: setCards[index]) {
                choosenCards.remove(at: chosenCardToRemove)
            } else {
                fatalError("LOL")
            }
            possibleSet.removeAll()
        }
    }

    // All setCards become "unremoveble"
    private func backAllCards() {
        for cardIndex in 0...setCards.count - 1 {
            setCards[cardIndex].isRemove = false
        }
    }
    
    // Create Set deck with all possible cards
    init() {
        for index in 0...deck - 1 {
            let setCard = SetCard(number: index.convertToTernary()[0], symbol: index.convertToTernary()[1], color: index.convertToTernary()[2], fill: index.convertToTernary()[3], identifier: index)
            setCards.append(setCard)
        }
        setCards.shuffle()
    }
}

extension Array {
    func checkIfSet() -> Bool {
        var specification = [Int]()
        var equasionCounter = 0
        var operationCounter = 0
        var differenceCounter = 0
        var result: Bool!
        for i in 0...4 {
            for index in stride(from: i, to: self.count, by: 4) {
                specification.append(self[index] as! Int)
                operationCounter += 1
                if operationCounter == 3 {
                    if Set(specification).count == 1 {
                        equasionCounter += 1
                    } else if Set(specification).count == 3 {
                        differenceCounter += 1
                    }
                    specification.removeAll()
                    operationCounter = 0
                }
            }
        }
        switch (equasionCounter,differenceCounter) {
        case (1,3),(0,4),(2,2),(3,1):
            result = true
        default:
            result = false
        }
        return result
    }
}

extension Int {
    /**
     Takes an Int and return a ternary value of it in array.
        
     ````
     let ternaryValueOfEightyEight = 81.convertToTernary()
     print(ternaryValueOfEightyEight)
     [2, 2, 2, 2]
    
     ````
    */
    func convertToTernary() -> [Int] {
        var ternaryArray = [Int]()
        var converter = 0
        var memorizor = self
        
        while ternaryArray.count <= 3 {
            converter = memorizor % 3
            ternaryArray += [converter]
            converter = memorizor / 3
            memorizor = converter
        }
        return ternaryArray.reversed()
    }
}








