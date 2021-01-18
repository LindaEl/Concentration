//
//  ViewController.swift
//  Concentration
//
//  Created by linda.elksnite on 28/12/2020.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards) //creates that big green arrow between Controller and Model. initialized Concentration. doesn't need type, because swift already knows its a type of Concentration (var game: Concentration = Concentration())

    var numberOfPairsOfCards: Int { //this is private(set), but doesnt need keyword set because it already is get only property
        return (cardButtons.count + 1) / 2 //here is a get func = read only, because no set
    }

    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }

    private func updateFlipCountLabel() {
        let attributes : [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }

    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber) // flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            updateViewFromModel() //to update our view when we choose a card
        } else {
            print("Error")
        }
    }

    private func updateViewFromModel() {
        for index in cardButtons.indices { //cool range thingy for arrays
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

//    private var emojiChoices = ["👻","🎃","🦇","😱","🙀","😈","🍭","🍬","🍎"]
    private var emojiChoices = "👻🎃🦇😱🙀😈🍭🍬🍎"

    private var emoji = [Card:String]() //Dictionary<Int,String>()

    private func emoji(for card: Card) -> String {
        if emojiChoices.count > 0, emoji[card] == nil {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        // you can use nested ifs by seperating them with coma
        // this code is same as:
        // if emojiChoices.count > 0 { if emoji[card.identifier] == nil {

        return emoji[card] ?? "?"
// shorter syntax for:
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
