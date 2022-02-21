//
//  SetViewController.swift
//  SetStanfordCourse
//
//  Created by Тимур Ярулин on 19.12.2020.
//

import UIKit

class SetViewController: UIViewController {
    // Enum for storing card's symbols
    enum CardView: String {
        case triangle = "▲"
        case circle = "●"
        case square = "◼︎"
    }
    
    // Implementation of the game
    private var game = SetGame()
    
    private var newIndex = 1
    
    private var setDictionary: [Int: CardView.RawValue] =
        [
            0: CardView.triangle.rawValue,
            1: CardView.circle.rawValue,
            2: CardView.square.rawValue
        ]
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet  private var setCardButtons: [UIButton]!
    
    @IBOutlet weak var dealCardsButton: UIButton!
    
    @IBAction private func dealMoreCards(_ sender: UIButton) {
        sender.setTitle("Deal 3 more cards", for: .normal)
        startGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = setCardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
        }
        drawChooseEffect()
        updateCard()
        
        scoreLabel.text = "Score: \(game.score)"
    }
    /// Starts game: show cards and score. Put cards on "game table"
    private func startGame() {
        for buttonIndex in 0...setCardButtons.count - 1 {
            setCardButtons[buttonIndex].backgroundColor = .white
            
            scoreLabel.textColor = .black
            
            setCardButtons[buttonIndex].layer.cornerRadius = 8.0
            
            createCardViewAt(index: buttonIndex)
        }
        dealCardsButton.isHidden = true
    }
    
    private func createCardViewAt(index: Int, removedIndex: Int? = nil) {
        var viewSetCard: SetCard!
        if let removedCard = removedIndex {
            viewSetCard = game.setCards[removedCard]
        } else {
            viewSetCard = game.setCards[index]
        }
        let cardTitleString = createCardViewFrom(card: viewSetCard)
        
        var foreground: UIColor?
        
        if viewSetCard.fill == 0 || viewSetCard.fill == 2 {
            foreground = cardTitleString.1
        } else {
            foreground = cardTitleString.1.withAlphaComponent(0.3)
        }
        
        let cardAttributetTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 32),
            .foregroundColor: foreground!,
            .strokeWidth: cardTitleString.2
        ]
        
        let cardTitle = NSAttributedString(string: cardTitleString.0, attributes: cardAttributetTitle )
        
        setCardButtons[index].setAttributedTitle(cardTitle, for: .normal)
    }
    
    private func createCardViewFrom(card: SetCard) -> (String, UIColor, Int) {
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
    
    private func drawChooseEffect() {
        for index in setCardButtons.indices {
            let cardButton = setCardButtons[index]
            let card = game.setCards[index]
            
            if card.isMatched {
                cardButton.layer.borderWidth = 3.0
                cardButton.layer.borderColor = UIColor.blue.cgColor
            } else {
                cardButton.layer.borderWidth = 0
                cardButton.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    private func updateCard() {
        for buttonIndex in 0...setCardButtons.count - 1 {
            if (game.setCards[buttonIndex].isRemove) && (newIndex <= 57) {
                createCardViewAt(index: buttonIndex, removedIndex:  (setCardButtons.count - 1) + newIndex)
                newIndex += 1
            }
        }
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
}




