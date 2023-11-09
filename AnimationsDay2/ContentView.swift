//
//  ContentView.swift
//  AnimationsDay2
//
//  Created by Maks Winters on 08.11.2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        NavigationStack {
            if isUnlocked {
                ScrollView(.vertical) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<cards.count, id: \.self) { circ in
                                CardsView(index: circ)
                            }
                        }
                        .scrollTargetLayout()
                        .padding()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .frame(height: 250)
                    Spacer()
                        .navigationTitle("Accounts")
                    TranListView()
                        .padding()
                }
            } else {
                Text("Locked")
            }
        }
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthenticated, error in
                if isAuthenticated {
                    isUnlocked = true
                } else {
                    print(error ?? 0)
                }
            }
            
        } else {
            // no authentication
            print(error ?? 0)
        }
        
    }
}

struct CardsView: View {
    
    var index: Int
    @State private var isShown = true
    
    var body: some View {
        if isShown {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(cards[index].color.gradient)
                        .frame(width: 350)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(style: StrokeStyle(lineWidth: 4))
                        }
                        .onTapGesture {
                            withAnimation {
                                isShown.toggle()
                            }
                        }
                    VStack {
                        Text(String(cards[index].cardNumber))
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .padding()
                        Text(cards[index].cardHolder)
                            .foregroundStyle(.white)
                    }
                    .shadow(radius: 10)
                }
            }
            .transition(.scale)
        } else {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(cards[index].color.gradient)
                        .frame(width: 350)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(style: StrokeStyle(lineWidth: 4))
                        }
                        .onTapGesture {
                            withAnimation {
                                isShown.toggle()
                            }
                        }
                        Text("CVV: \(String(cards[index].CVV))")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .padding()
                    .shadow(radius: 10)
                }
            }
            .transition(.scale)
        }
    }
}

struct Card {
    var id = UUID()
    var cardNumber: Int
    var CVV: Int
    var cardHolder: String
    var color: Color
}

let cards = [Card(cardNumber: 5385832950285923, CVV: 7832, cardHolder: "Mike", color: .red),
             Card(cardNumber: 5385832950282573, CVV: 4062, cardHolder: "William", color: .yellow),
             Card(cardNumber: 5383486530282573, CVV: 0163, cardHolder: "Nico", color: .purple)]

#Preview {
    ContentView()
}
