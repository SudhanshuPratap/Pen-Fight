//
//  ContentView.swift
//  Pen Fight
//
//  Created by Sudhanshu on 17/02/26.
//
import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            SpriteView(scene: makeScene(size: geometry.size))
                .ignoresSafeArea()
        }
    }
    
    private func makeScene(size: CGSize) -> SKScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .resizeFill
        return scene
    }
}



#Preview {
    ContentView()
}
