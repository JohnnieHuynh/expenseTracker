//
//  Expenses.swift
//  expenseTracker
//
//  Created by Johnny Huynh on 7/26/22.
//

import Foundation

class Expenses: ObservableObject {
    var personalItems : [ExpenseItem] {
            get { items.filter { $0.type == "Personal" } }
            set { }
        }

    var businessItems: [ExpenseItem] {
        get { items.filter { $0.type == "Business" } }
    }
    
    var totalExpensesAmt: Double {
        items.map {$0.amount}.reduce(0, +)
    }

    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        //Look for data with key
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            //There is a key and therefore there is data, so then decode
            if let decodedeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedeItems
                return
            }
        }
        
        items = []
    }
}
