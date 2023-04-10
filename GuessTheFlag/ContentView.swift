//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shihab Chowdhury on 4/10/23.
//

import SwiftUI

var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]

struct ContentView: View {
    struct GuessTheFlagGame {
        let correctAnswerIndex = Int.random(in: 0...2)
        var randomCountries = [String]()
        var correctAnswer: String {
            get {
                randomCountries[correctAnswerIndex]
            }
        }
        
        init() {
            while randomCountries.count < 3 {
                let randomCountry = countries.randomElement()
                
                guard let randomCountry = randomCountry else {
                    continue
                }
                
                if !randomCountries.contains(randomCountry) {
                    randomCountries.append(randomCountry)
                }
            }
        }
    }

    let game = GuessTheFlagGame()

    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Tap the flag of")
                Text(game.correctAnswer)
            }
            
            ForEach(0..<game.randomCountries.count, id: \.self) { country in
                Button {
                    
                } label: {
                    Image(game.randomCountries[country])
                        .renderingMode(.original)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
