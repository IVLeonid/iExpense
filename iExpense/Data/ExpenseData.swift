//
//  ExpenseData.swift
//  iExpense
//
//  Created by Леонід Іванов on 06.07.2026.
//

import SwiftData

@Model
class ExpenseData {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
