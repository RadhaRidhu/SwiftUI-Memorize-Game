//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Radha Natesan on 2/24/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let themeStore = GameTheme()
    var body: some Scene {
        WindowGroup {
            ThemeChooser(themeStore: themeStore)
        }
    }
}
