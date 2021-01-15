//
//  Card.swift
//  Concentration
//
//  Created by linda.elksnite on 08/01/2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    //var above are stored with each Card, but the static one is stored with a Card TYPE
    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 //Don't need to say Card. because we're in a static method and can access all static vars
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
