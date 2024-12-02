//
//  ContentView.swift
//  12
//
//  Created by Jonathan V on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "dice")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Spacer()
                Text("Welcome to 12!")
                    .font(.system(size: 40, weight: .heavy))
                Spacer()
                
                NavigationLink(destination: diceView()) {
                    Text("Go to Dice View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
                
                .navigationTitle("Title Screen")
                .toolbar(.hidden, for: .navigationBar)
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
