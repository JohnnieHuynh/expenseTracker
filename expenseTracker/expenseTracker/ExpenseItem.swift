//
//  ExpenseItem.swift
//  expenseTracker
//
//  Created by Johnny Huynh on 7/26/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
