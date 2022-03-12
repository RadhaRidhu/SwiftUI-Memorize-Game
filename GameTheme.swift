//
//  GameTheme.swift
//  Memorize
//
//  Created by Radha Natesan on 2/26/22.
//

import Foundation


class GameTheme:ObservableObject {
    private(set) var themes : Array<Theme>
    //private var currentTheme:Theme
    
    struct Theme : Identifiable {
        var name:String
        var content:String
        var numberOfPairsOfCardsToShow: Int
        var color:RGBAColor
        var id:Int
        
        fileprivate init(name:String,content:String,numberOfPairsOfCardsToShow:Int,color:RGBAColor,id:Int){
            self.name = name
            self.content = content
            self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow
            self.color = color
            self.id = id
        }
    }
    
    

//    func changeTheme() -> Theme{
//        if let newTheme = themes.randomElement(){
//            currentTheme = newTheme
//        }
//        
//        return currentTheme
//    }
//    func getCurrentTheme()->Theme{
//        return currentTheme
//    }
    //Set default theme
    init(){
        themes = Array<Theme>()
        addTheme(name: "Smileys", numberOfPairsOfCardsToShow: 10, color: RGBAColor(red: 0.0, green: 1.0, blue: 0, alpha: 1), content: "😀😁😏🤓😆😅😖😠🤩🥳🥰🥸")
        addTheme(name: "Vehicles", numberOfPairsOfCardsToShow: 10, color: RGBAColor(red: 0, green: 0, blue: 1.0, alpha: 1), content: "🚌🏎🚜🚑🚕🚙🚎🚓🚒🛻🚛")
        addTheme(name: "Hearts", numberOfPairsOfCardsToShow: 8, color: RGBAColor(red: 1.0, green: 0, blue: 0, alpha: 1), content: "❤️💚💕💔💙🖤🤎💝")
        
        //addTheme(name: name, numberOfPairsOfCardsToShow: numberOfPairsOfCardsToShow, color: color, content: content)

    }
    
    //MARK: Intent
    func addTheme(name:String,numberOfPairsOfCardsToShow:Int,color:RGBAColor,content:String){
        let uniqueId = themes.count
        let theme = Theme(name: name, content: content, numberOfPairsOfCardsToShow: numberOfPairsOfCardsToShow, color: color,id: uniqueId)
        themes.append(theme)
    }
}
