//
//  Concentration.swift
//  Concentration
//
//  Created by linda.elksnite on 08/01/2021.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]() //same as Array<Card>; creates an empty array

    private var indexOfOneAndOnlyFaceUpCard: Int? { //there either is or is not a only one face up card, so we use an optional
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set { //by default this is set(newValue)
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards match or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    //we always need to know how many cards to load, so we do need a initializer anyways
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //same as writing cards.append(card) two times - to add card and matching card to the array
        }
        //TODO: Shuffle the cards HOMEWORK
    }
}
