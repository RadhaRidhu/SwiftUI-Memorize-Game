//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Radha Natesan on 3/11/22.
//

import SwiftUI


struct ThemeChooser: View {

    @ObservedObject var themeStore:GameTheme
    
    var body: some View {
        NavigationView{
            List{
                ForEach(themeStore.themes){theme in
                    NavigationLink(destination:EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))){
                        VStack(alignment: .leading){
                            Text(theme.name).foregroundColor(Color(rgbaColor: theme.color))
                            Text(theme.content)
                        }
                    }
                    
                }
            }
            .navigationTitle("Memorize!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{EditButton()}
                ToolbarItem(placement: .navigationBarLeading){
                    Button("+"){
                        
                    }
                }
            }
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        let theme = GameTheme()
        ThemeChooser(themeStore: theme)
    }
}

