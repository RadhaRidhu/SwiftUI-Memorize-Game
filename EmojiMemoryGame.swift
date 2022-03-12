//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Radha Natesan on 2/25/22.
//

import SwiftUI



class EmojiMemoryGame : ObservableObject {

    typealias Card = MemoryGame<String>.Card
    private(set) var theme:GameTheme.Theme
    
    
    @Published private var model:MemoryGame<String> 
      
    static func createMemoryGame(emojis:Array<String>,numberOfPairsOfCards:Int)-> MemoryGame<String> {
    
        MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards){ pairIndex in
            print(pairIndex,Array(emojis[0]))
            return emojis[pairIndex]
        
        }
    }

 
    init(theme:GameTheme.Theme){
        self.theme = theme
        let emojis = Array(theme.content).map({String($0)})
        model = EmojiMemoryGame.createMemoryGame(emojis: emojis,numberOfPairsOfCards:8)
    }
    
    
    var cards:Array<Card>{
        return model.cards
    }
    
    
    //MARK: - Intent(s)
    func choose(card:Card){
        model.choose(card)
    }

    func getScores()->String{
        return String(model.scores)
    }
    func shuffle(){
        model.shuffle()
    }
//    func restart(){
//        let theme = modelTheme.getCurrentTheme()
//        model = EmojiMemoryGame.createMemoryGame(emojis: theme.content.shuffled(),numberOfPairsOfCards: min( theme.numberOfPairsOfCardsToShow,theme.content.count))
//    }
}
