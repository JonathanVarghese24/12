//
//  ContentView.swift
//  12
//
//  Created by Jonathan V on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Welcome to 12!")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: diceView()) {
                        Text("Start Game")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                    
                    Image(systemName: "dice")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                        .font(.system(size: 60))
                }
                .padding()
            }
            .navigationTitle("Title Screen")
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
