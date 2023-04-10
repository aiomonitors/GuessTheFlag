//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shihab Chowdhury on 4/10/23.
//

import SwiftUI

var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]

struct GuessTheFlagGame {
    let correctAnswer = Int.random(in: 0...2)
    var randomCountries = Set<String>()
    
    init() {
        while randomCountries.count < 3 {
            let randomCountry = countries.randomElement()
            
            guard let randomCountry = randomCountry else {
                continue
            }
            
            if !randomCountries.contains(randomCountry) {
                randomCountries.insert(randomCountry)
            }
        }
    }
}

struct ContentView: View {
    var correctAnswer = Int.random(in: 0...countries.count)

    var body: some View {
        VStack {
            Text("Tap the flag of")
            Text(countries[correctAnswer])
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
