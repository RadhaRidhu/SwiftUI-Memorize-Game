//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Radha Natesan on 2/24/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game:EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                gameHeader
                gameBody
                //shuffle
                
                //score
         
            }
            deckBody
        }
        .padding(.horizontal)
        .foregroundColor(Color(rgbaColor: game.theme.color))
        
    }
    
    @State private var dealt = Set<Int>()
    
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    	
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool{
        return !dealt.contains(card.id)
    }
    private func dealAnimation(for card:EmojiMemoryGame.Card) -> Animation{
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * CardConstants.totalDealDuration/Double(game.cards.count)
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    private func zIndex(of card:EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    var gameBody: some View{
        AspectVGrid(items:game.cards,aspectRatio:2/3,content:{ card in
            if(isUndealt(card) ||  (card.isMatched && !card.isFaceUp)){
                Color.clear
            }else{
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(){
                            game.choose(card: card)
                        }
                    }
            }
            
        })
     
    }
    var deckBody:some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)){card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
            }
        }
        .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeight)
        .foregroundColor(Color(rgbaColor: game.theme.color))
        .onTapGesture {
            for card in game.cards{
                withAnimation(dealAnimation(for: card)){
                    deal(card)
                }
            }
        }
    }
    var gameHeader:some View{
        HStack{
            restart
            Spacer()
            Text(game.theme.name)
            Spacer()
            Button(action: {
                dealt = []
                //game.changeTheme()
            }, label: {Text("New Game")})
                
        }.foregroundColor(.black)
    }
    var score:some View{
        Text("Score: \(game.getScores())")
    }
    var shuffle:some View{
        Button("Shuffle"){
            withAnimation{
                game.shuffle()
            }
        }
    }
    var restart:some View{
        Button("Restart"){
            withAnimation{
                dealt=[]
                //game.restart()
            }
        }
    }
    private struct CardConstants{
        static let color = Color.red
        static let aspectRatio:CGFloat = 2/3
        static let dealDuration:Double = 0.5
        static let totalDealDuration:Double = 2
        static let unDealtHeight:CGFloat = 90
        static let unDealtWidth:CGFloat = unDealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card:EmojiMemoryGame.Card

    
    var body: some View{
        GeometryReader{ geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).opacity(0.5)
         
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched )
                    .font(.system(size:DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                
            }.cardify(isFaceUp: card.isFaceUp)
        }
        
       
    }
    private func scale(thatFits size:CGSize) -> CGFloat	{
        min(size.width,size.height)/(DrawingConstants.fontSize/DrawingConstants.fontScale)
        	
    }
    private struct DrawingConstants{
        static let cornerRadius : CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontSize : CGFloat = 32
        static let fontScale:CGFloat = 0.7
    }
}


//
//struct ContentView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        return EmojiMemoryGameView(game: game)
//            
//    }
//}
