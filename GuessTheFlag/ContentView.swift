//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by bnewton on 2/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnwser = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: UnitPoint.bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnwser])
                        .foregroundColor(.white)
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
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    
        func flagTapped(_ number: Int){
            if number == correctAnwser {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
            }
            
            showingScore = true
        }
    
    
        func askQuestion() {
            countries = countries.shuffled()
            correctAnwser = Int.random(in: 0...2)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
        
    }
}
