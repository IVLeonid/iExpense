//
//  AddView.swift
//  iExpense
//
//  Created by Леонід Іванов on 29.04.2026.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Query var expenses: [ExpenseData]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        
                        Text(expense.type)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(expense.amount)")
                }
            }
            .onDelete(perform: deleteExpense)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
    init(searchString: String, sortOrder: [SortDescriptor<ExpenseData>]) {
        let predicate = #Predicate<ExpenseData> { expense in
            searchString == "All" || expense.type == searchString
        }
        
        _expenses = Query(filter: predicate, sort: sortOrder)
    }
}

#Preview {
    // Build a model container for preview
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container: ModelContainer
    do {
        container = try ModelContainer(for: ExpenseData.self, configurations: config)
        // Seed sample data
        let sampleData = ExpenseData(name: "New Book", type: "Business", amount: 50)
        container.mainContext.insert(sampleData)
    } catch {
        // If container creation fails, return a fallback view
        return Text("Помилка створення Preview: \(error.localizedDescription)")
    }
    
    // Always return a single View from the macro closure
    return ExpenseView(
        searchString: "",
        sortOrder: [SortDescriptor(\ExpenseData.name)]
    )
    .modelContainer(container)
}
