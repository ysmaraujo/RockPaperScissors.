//
//  ContentView.swift
//  RockPaperScissors.
//
//  Created by Yasmin araujo on 11/06/2024.
//

import SwiftUI

struct choicePlayer: View {
    var buttonChoice: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 110)
            .foregroundStyle(.yellow)
            Text(buttonChoice)
                .font(.system(size: 80))
                .shadow(radius: 3)
        }
    }
}

struct ContentView: View {
    let moves =  ["✊🏼", "🖐🏼", "✌🏼"]
   
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var numberOfQuestion = 1
    @State private var restartGame = false
    
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
           
            VStack(spacing: 30) {
               Spacer()
                Text("Rock, Paper & Scissors")
                    .font(.title).bold()
                    .foregroundStyle(.white)
                Spacer()
                Text("Computer has played...")
                    .font(.headline)
                    .foregroundStyle(.white)
                choicePlayer(buttonChoice: moves[computerChoice])
                
                Text("You should \(shouldWin ? "win" : "lose")")
                    .foregroundStyle(shouldWin ? .green : .red)
                    .font(.title2).bold()
                    .foregroundStyle(.white)
                
                
                HStack {
                    ForEach (0..<3) { number in
                        Button {
                           playGame(number)
                        } label: {
                            choicePlayer(buttonChoice: moves[number])
                        }
                    }
                }
                Spacer()
                Text("Score: \(userScore)")
                    .font(.system(.title))
                    .foregroundStyle(.white)
                Spacer()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(userScore)")
            }
            .alert("Game Over", isPresented: $restartGame) {
                Button("New Game", action: resetGame)
            } message: {
                Text("Your final is score is \(userScore)")
            }
        }
    }
    func playGame(_ choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
    
        if didWin {
            userScore += 1
            scoreTitle = "You're the winner"
        } else {
            userScore -= 1
            scoreTitle = "The computer is the winner"
        }
        
        showingScore = true
        
        if numberOfQuestion == 10 {
            restartGame = true
        }
    }
    
    func askQuestion() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
        numberOfQuestion += 1
    }
    
    func resetGame() {
        askQuestion()
        numberOfQuestion = 1
        userScore = 0
    }

}

#Preview {
    ContentView()
}
