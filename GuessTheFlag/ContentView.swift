//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by bnewton on 2/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var restartGame = false

    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnwser = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var timesPlayed = 0
    
    
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
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnwser])
                            .font(.largeTitle.weight(.semibold))
                    }

                    
                    ForEach(0..<3) { number in
                        Button {
                        
                            flagTapped(number)
                        
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        
        .alert("Your final score was \(score)", isPresented: $restartGame){
            Button("Reset Game", action: resetGame)
            }
        
        }
    

        
    
        func flagTapped(_ number: Int){
            if number == correctAnwser {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong! That’s the flag of \(countries[number])"
                score -= 1
            }
            timesPlayed += 1
            showingScore = true
            
            if timesPlayed == 8 {
                restartGame = true
            }
            
        }
    

        func askQuestion() {
            countries = countries.shuffled()
            correctAnwser = Int.random(in: 0...2)
        }
    
    
        func resetGame() {
            restartGame = false
            timesPlayed = 0
            score = 0
            askQuestion()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
        
    }
}
