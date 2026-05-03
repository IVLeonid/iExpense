//
//  ContentView.swift
//  iExpense
//
//  Created by Леонід Іванов on 24.04.2026.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}



struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal Expenses") {
                    ForEach(personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .padding(0.1)
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .padding(3)
                        .foregroundStyle(.primary)
                        .listRowBackground(getBackgroundColor(for: item.amount))
                        
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, in: personalItems)
                    }
                }
                
                Section("Business Expensses") {
                    ForEach(businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .padding(0.1)
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .padding(3)
                        .foregroundStyle(.primary)
                        .listRowBackground(getBackgroundColor(for: item.amount))
                        
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, in: businessItems)
                    }
                }
                
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        for offset in offsets {
            let itemToDelete = inputArray[offset]
            expenses.items.removeAll(where: { $0.id == itemToDelete.id })
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
