//
//  ContentView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var habits: [String] = [String]()
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(habits, id: \.self) {habit in
                    NavigationLink(habit) {
                        Text(habit)
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                NavigationLink {
                    AddHabitView(habits: $habits)
                } label: {
                    Label("Add Habit", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItem(at offset: IndexSet) {
        habits.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
