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
    
    var body: some View {
        VStack {
            Text("Get the closest to")
                .font(.title)
            Text("12 as you can!")
                .font(.title)
            Spacer()
            HStack {
                Image("pips \(randomValue)")
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                    .rotationEffect(.degrees(rotation))
                    .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                    .padding()
                    .onTapGesture {
                        chooseRandom(times: 3)
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotation += 360
                        }
                    }
                Image("pips \(randomValue2)")
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                    .rotationEffect(.degrees(rotation2))
                    .rotation3DEffect(.degrees(rotation2), axis: (x: 1, y: 1, z: 0))
                    .padding()
                    .onTapGesture {
                        chooseRandom2(times: 3)
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotation2 += 360
                        }
                    }
            }
            Spacer()
            Text("Score: \(score)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
        .padding()
    }
    
    func updateScore() {
        score = randomValue + randomValue2
    }
    
    func chooseRandom(times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                randomValue2 = Int.random(in: 1...6)
                chooseRandom2(times: times - 1)
                if times == 1 {
                    updateScore()
                }
            }
        }
    }
}

#Preview {
    diceView()
}
