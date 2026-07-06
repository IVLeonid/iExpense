//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Леонід Іванов on 24.04.2026.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseData.self)
    }
}
