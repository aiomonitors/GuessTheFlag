//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shihab Chowdhury on 4/10/23.
//

import SwiftUI

var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]

struct GuessTheFlagGame {
    let correctAnswerIndex = Int.random(in: 0...2)
    var randomCountries = [String]()
    var correctAnswer: String {
        get {
            randomCountries[correctAnswerIndex]
        }
    }
    
    init() {
        randomCountries.append(contentsOf: countries.shuffled()[...2])
    }
    
    func getFlag(at index: Int) -> String {
        randomCountries[index]
    }
}

struct ContentView: View {
    @State private var game = GuessTheFlagGame()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var showingEnd = false
    
    let questionsToAsk = 4

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(game.correctAnswer)
                            .foregroundColor(.secondary)
                            .font(.largeTitle.weight(.semibold))
                            .fontDesign(.monospaced)
                    }
                    
                    ForEach(0..<game.randomCountries.count, id: \.self) { index in
                        Button {
                            flagTapped(index)
                        } label: {
                            Image(game.randomCountries[index])
                                .renderingMode(.original)
                                .shadow(radius: 5)
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("Your score is \(score)\nYou have \(questionsToAsk - questionsAsked) questions remaining")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .alert("Game over!", isPresented: $showingEnd) {
                        Button("Continue", action: resetGame)
                    } message: {
                        Text("You have completed the game!")
                    }
                
                
                Spacer()

            }
            .padding(.horizontal, 20)
        }
    }
    
    func askQuestion() {
        game = GuessTheFlagGame()
    }
    
    func flagTapped(_ number: Int) {
        questionsAsked += 1
        
        if number == game.correctAnswerIndex {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! Thats the flag of \(game.getFlag(at: number))"
        }
        
        if questionsAsked == questionsToAsk {
            showingEnd = true
            return
        }
        
        showingScore = true
    }
    
    func resetGame() {
        questionsAsked = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
