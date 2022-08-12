//
//  ContentView.swift
//  expenseTracker
//
//  Created by Johnny Huynh on 7/20/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section(header: Text("Business")) {
                    ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                
                Section(header: Text("Total")) {
                    HStack {
                        Spacer()
                        Text("\(expenses.totalExpensesAmt, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    }
                }
                
            }
            .navigationTitle("Expense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName:  "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        //Look at each item
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
                //Delete item from expenses
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
                //Delete item from expenses
                expenses.items.remove(at: index)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
