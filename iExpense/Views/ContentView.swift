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
    @State private var filter: String = "All"
    let filterOptions = ["Business", "Personal", "All"]
    @State private var sortOrder = [
            SortDescriptor(\ExpenseData.name),
            SortDescriptor(\ExpenseData.amount)
        ]
    
    var body: some View {
        NavigationStack {
            ExpenseView(searchString: filter, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add expense", systemImage: "plus") {
                            isPresented = true
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("by Name")
                                    .tag([SortDescriptor(\ExpenseData.name)])
                                
                                Text("by Amount")
                                    .tag([SortDescriptor(\ExpenseData.amount)])
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                            Picker("Filter", selection: $filter) {
                                ForEach(filterOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                    
//                    ToolbarItem() {
//                        Button("Reverse", systemImage: "arrow.up.arrow.down") {
//                            
//                        }
//                    }
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
