//
//  ContentView.swift
//  iExpense
//
//  Created by Леонід Іванов on 24.04.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ExpenseView()
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add expense", systemImage: "plus") {
                            isPresented = true
                        }
                    }
                }
        }
        .sheet(isPresented: $isPresented) {
            AddExpenseView()
        }
    }
    
    func getBackgroundColor(for amount: Double) -> Color? {
        if amount <= 10 {
            return Color.green.opacity(0.15)
        } else if amount <= 100 {
            return Color.blue.opacity(0.17)
        } else {
            return Color.red.opacity(0.25)
        }
    }
}

#Preview {
    ContentView()
}
