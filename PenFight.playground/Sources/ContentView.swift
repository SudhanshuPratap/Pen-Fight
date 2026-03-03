//
//  ContentView.swift
//  
//
//  Created by Sudhanshu on 01/03/26.
//


import SwiftUI

public struct ContentView: View {

    /// Tracks whether the player has tapped "Start Game" on the menu.
    @State private var isGameStarted = false

    public init() {}

    public var body: some View {
        ZStack {
            if isGameStarted {
                // ── Active game ──
                GameView(onExit: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isGameStarted = false
                    }
                })
            } else {
                // ── Main menu ──
                MenuView {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isGameStarted = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
