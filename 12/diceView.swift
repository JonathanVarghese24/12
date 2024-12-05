//
//  diceView.swift
//  12
//
//  Created by Jonathan V on 12/2/24.
//

import SwiftUI

struct diceView: View {
    @State private var randomValue = 0
    @State private var randomValue2 = 0
    @State private var rotation = 0.0
    @State private var rotation2 = 0.0
    @State private var score = 0
    @State private var currentPlayer = 1
    @State private var player1Score = 0
    @State private var player2Score = 0
    @State private var showingRollOptions = false
    @State private var gameOver = false
    @State private var rollsRemaining = 3
    @State private var selectDie1 = false
    @State private var selectDie2 = false
    
    var body: some View {
        
        VStack {
            Text("Get as close to 12 as possible!")
                .font(.title)
            Text("Player \(currentPlayer)'s turn")
                .font(.headline)
                .padding()
                .padding()
            
            Text("Current Score: \(score)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Rolls remaining: \(rollsRemaining)")
                .font(.subheadline)
                .padding()
            
            HStack {
                VStack {
                    Image("pips \(randomValue)") // die 1
                        .resizable()
                        .frame(width: 125, height: 125, alignment: .center)
                        .rotationEffect(.degrees(rotation))
                        .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                        .padding()
                    
                    Button(action: {
                        selectDie1.toggle()
                    }) {
                        Text(selectDie1 ? "Selected" : "Select")
                    }
                    .padding(8)
                    .background(selectDie1 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                VStack {
                    Image("pips \(randomValue2)") // die 2
                        .resizable()
                        .frame(width: 125, height: 125, alignment: .center)
                        .rotationEffect(.degrees(rotation2))
                        .rotation3DEffect(.degrees(rotation2), axis: (x: 1, y: 1, z: 0))
                        .padding()
                    
                    Button(action: {
                        selectDie2.toggle()
                    }) {
                        Text(selectDie2 ? "Selected" : "Select")
                    }
                    .padding(8)
                    .background(selectDie2 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            if showingRollOptions && rollsRemaining > 0 {
                Button("Re-roll Selected Dice") {
                    rerollSelectedDice()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(!selectDie1 && !selectDie2)
            }
            
            if !showingRollOptions {
                Button("Start Rolling") {
                    showingRollOptions = true
                    rollDice(count: 2)
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Button(rollsRemaining == 0 ? "End Turn" : "End Turn Early") {
                endTurn()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text("Player 1 Score: \(player1Score)")
            Text("Player 2 Score: \(player2Score)")
        }
        .padding()
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"),
                  message: Text(getWinnerMessage()),
                  dismissButton: .default(Text("New Game")) {
                resetGame()
            })
        }
    }
    
    func rerollSelectedDice() {
        if rollsRemaining > 0 {
            rollsRemaining -= 1
            if selectDie1 {
                chooseRandom(times: 3)
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                    rotation += 360
                }
            }
            if selectDie2 {
                chooseRandom2(times: 3)
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                    rotation2 += 360
                }
            }
            selectDie1 = false
            selectDie2 = false
        }
    }
    
    func rollDice(count: Int) {
        if rollsRemaining > 0 {
            rollsRemaining -= 1
            chooseRandom(times: 3)
            chooseRandom2(times: 3)
            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                rotation += 360
                rotation2 += 360
            }
        }
    }
    
    func updateScore() {
        score = randomValue + randomValue2
    }
    
    func chooseRandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                randomValue = Int.random(in: 1...6)
                chooseRandom(times: times - 1)
                if times == 1 {
                    updateScore()
                }
            }
        }
    }
    
    func chooseRandom2(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                randomValue2 = Int.random(in: 1...6)
                chooseRandom2(times: times - 1)
                if times == 1 {
                    updateScore()
                }
            }
        }
    }
    
    func endTurn() {
        if currentPlayer == 1 {
            player1Score = score
            currentPlayer = 2
        } else {
            player2Score = score
            gameOver = true
        }
        resetTurn()
    }
    
    func resetTurn() {
        score = 0
        randomValue = 0
        randomValue2 = 0
        showingRollOptions = false
        rollsRemaining = 3
        selectDie1 = false
        selectDie2 = false
    }
    
    func resetGame() {
        currentPlayer = 1
        player1Score = 0
        player2Score = 0
        resetTurn()
        gameOver = false
    }
    
    func getWinnerMessage() -> String {
        let FirstTurn = abs(12 - player1Score) // abs, makes sure that the number that is returned isnt negative
        let SecondTurn = abs(12 - player2Score) // abs, makes sure that the number that is returned isnt negative
        
        if FirstTurn < SecondTurn {
            return "Player 1 wins!"
        } else if SecondTurn < FirstTurn {
            return "Player 2 wins!"
        } else {
            return "It's a tie!"
        }
    }
}

#Preview {
    diceView()
}
