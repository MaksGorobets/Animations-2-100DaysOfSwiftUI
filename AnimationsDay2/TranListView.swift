//
//  TranListView.swift
//  AnimationsDay2
//
//  Created by Maks Winters on 09.11.2023.
//

import SwiftUI

struct TranListView: View {
    
    var body: some View {
        VStack {
            ForEach(0..<11, id: \.self) { cont in
                Transaction()
            }
        }
    }
}

struct Transaction: View {
    
    let charts = ["chart.line.uptrend.xyaxis.circle.fill", "chart.line.downtrend.xyaxis.circle.fill"]
    
    let positiveNegative = ["+", "-"]
    
    var body: some View {
        HStack {
            HStack {
                Text("Transaction")
                Image(systemName: charts.randomElement() ?? "globe")
                    .foregroundStyle(.blue)
            }
            .padding()
            Spacer()
            Text(positiveNegative.randomElement() ?? "?")
            Text("\(Int.random(in: 1...10000)) $")
                .padding()
            
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.primary, lineWidth: 3)
        )
    }
}

#Preview {
    TranListView()
}
