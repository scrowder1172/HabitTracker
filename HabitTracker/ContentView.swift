//
//  ContentView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

/// Last place: Created class and need to add class to add form to save habits
/// wanted to use enum for drop list of habit type
/// integrate class into add process

struct ContentView: View {
    @State private var habits: Habits = Habits()
    
    var body: some View {
        NavigationStack {
            
            List {
                HabitSectionView(habits: habits, habitType: .personal, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .health, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .work, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .school, onDelete: removeItem)
            }
            .navigationTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton())
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
        habits.habit.remove(atOffsets: offset)
    }
}


#Preview {
    ContentView()
}
