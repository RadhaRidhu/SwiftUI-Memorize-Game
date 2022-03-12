//
//  MemoryGame.swift
//  Memorize
//
//  Created by Radha Natesan on 2/25/22.
//

import Foundation

struct MemoryGame <CardContent> where CardContent  : Equatable{ //Dont care type
    private(set) var cards:Array<Card>  //Read only

    
    private var indexOfTheOneAndOnlyFaceUpCard:Int?
    private(set) var scores:Int = 0
    mutating func choose(_ card:Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                                             !cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched{
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if(cards[potentialMatchIndex].content == cards[chosenIndex].content){
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    scores = scores + 2
                    
                }else{
                    if(cards[potentialMatchIndex].isSeen){
                        scores = scores - 1
                    }
                    if(cards[chosenIndex].isSeen){
                        scores = scores - 1
                    }
                    cards[chosenIndex].isSeen = true
                    cards[potentialMatchIndex].isSeen = true
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
	
    }
    mutating func shuffle(){
        cards.shuffle()
    }
    init(numberOfPairsOfCards:Int,createCardContent:(Int)->CardContent){
        cards = Array<Card>()
        //Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content:content,id: pairIndex*2))
            cards.append(Card(content:content,id: pairIndex*2+1))
        }
        cards = cards.shuffled()
        indexOfTheOneAndOnlyFaceUpCard = nil
        
    }
    
    struct Card : Identifiable{
        var isFaceUp:Bool = false
        var isMatched: Bool = false
        var isSeen:Bool = false
        let content : CardContent
        let id: Int
    }
}
