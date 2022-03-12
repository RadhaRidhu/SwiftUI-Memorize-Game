//
//  Cardify.swift
//  Memorize
//
//  Created by Radha Natesan on 3/3/22.
//

import SwiftUI

struct Cardify : AnimatableModifier{
    
    var rotation:Double //Angle in Degree
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double{
        get{rotation}
        set{rotation = newValue}
    }
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
            }else{
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }.rotation3DEffect(Angle(degrees: rotation), axis: (0,1,0))
        
    }
    
    private struct DrawingConstants{
        static let cornerRadius : CGFloat = 20
        static let lineWidth: CGFloat = 3
    }
}


extension View {
    func cardify(isFaceUp:Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
