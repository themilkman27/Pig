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
        NavigationView() {
            ZStack {
                Color.gray.opacity(0.7).ignoresSafeArea()
                VStack {
                    Image("Pig").resizable().frame(width: 150, height: 150)
                    customText(text: "Pig")
                    Image("pips \(randomValue)")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .rotationEffect(.degrees(rotation))
                        .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                        .padding(50)
                    customText(text: "Turn Score: \(turnScore)")
                    HStack {
                        Button("Roll") {
                            chooseRandom(times: 3)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(customButtonStyle())
                        Button("Hold") {
                            gameScore += turnScore
                            endTurn()
                            withAnimation(.easeInOut(duration: 1)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(customButtonStyle())
                    }
                    customText(text: "Game Score: \(gameScore)")
                    NavigationLink("How To Play", destination: InstructionsView())
                        .font(Font.custom("Marker Felt", size: 24))
                        .padding()
                    Spacer()
                }
            }
        }
        .padding()
    }
    func endTurn() {
        turnScore = 0
        randomValue = 0
    }
    func chooseRandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                randomValue = Int.random(in: 1...6)
                chooseRandom(times: times - 1)
            }
        }
        if times == 0 {
            if randomValue == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    endTurn()
                }
            }
            else {
                turnScore += randomValue
            }
        }
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
struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50)
            .font(Font.custom("Maker Felt", size: 24))
            .padding()
            .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct InstructionsView: View {
    var body: some View{
        ZStack{
            Color.gray.opacity(0.7).ignoresSafeArea()
            VStack {
                Image("Pig").resizable().frame(width: 150, height: 150)
                Text("Pig").font(.title)
                VStack(alignment: .leading) {
                    Text ("In the game of Pig, players take individual turns. Each turn, a player repeatedly rolls a single die until either a pig is rolled or the player decidesto \"hold\".")
                        .padding()
                    Text ("If the player rolls a pig, they score nothing, and it becomes the next player's turn.")
                        .padding()
                    Text ("If the player rolls any other number, it is added to their turn total, and the player's turn continues.")
                        .padding()
                    Text ("If a player chooses to \"(hold\", their turn total is added to their game score, and it becomes the next player's turn.")
                        .padding()
                    Text("A player wins the game when the game score becomes 100 or more on their turn.")
                        .padding()
                }
                Spacer()
            }
        }
    }
}
