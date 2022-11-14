//
//  ContentView.swift
//  Pig
//
//  Created by Owen Johnson on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var turnScore = 0
    @State private var gameScore = 0
    @State private var randomValue = 0
    @State private var rotation = 0.0
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            VStack {
                Image("Pig").resizable().frame(width: 150, height: 150)
                customText(text: "Pig")
                Image("pips")
                customText(text: "Turn Score: \(turnScore)")
                customText(text: "Game Score: \(gameScore)")
                Spacer()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct customText: View {
    let text : String
    var body : some View {
        Text(text) .font(Font.custom("Marker Felt", size: 36))
    }
}
