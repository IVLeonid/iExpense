//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Леонід Іванов on 06.07.2026.
//

import SwiftData
import SwiftUI

struct AddExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var expenses: [ExpenseData]
    
    @State private var name: String = ""
    @State private var amount: Double = 0
    @State private var type: String = ""
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        Form {
            TextField("Name of expense", text: $name)
            
            Picker("Type of expense", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        
        Spacer()
        
        Button("Save") {
            let newExpense = ExpenseData(name: name, type: type, amount: amount)
            modelContext.insert(newExpense)
            dismiss()
        }
        .padding(20)
    }
}

#Preview {
    AddExpenseView()
}
