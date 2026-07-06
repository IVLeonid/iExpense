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
        List(expenses) { expense in
            
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
        
        //        .navigationTitle(expenses.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        //        .toolbar {
        //            ToolbarItem(placement: .topBarLeading) {
        //                Button("Cancel") {
        //                    dismiss()
        //                }
        //            }
        
        //            ToolbarItem(placement: .topBarTrailing) {
        //                Button("Save") {
        //                    let item = ExpenseItem(name: name, type: type, amount: amount)
        //                    expenses.items.append(item)
        //                    dismiss()
        //                }
        //            }
        //        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseData.self, configurations: config)
        
        let sampleData = ExpenseData(name: "New Book", type: "Business", amount: 50)
        container.mainContext.insert(sampleData)
        
        return ExpenseView()
            .modelContainer(container)
        
    } catch {
        return Text("Помилка створення Preview: \(error.localizedDescription)")
    }
}
