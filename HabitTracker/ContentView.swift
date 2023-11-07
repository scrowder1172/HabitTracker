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
                ForEach(habits.habit) {habit in
                    NavigationLink(habit.title) {
                        Text(habit.title)
                        Text(habit.description)
                        Text(habit.type.rawValue)
                        Text(habit.dateAdded.formatted(date: .long, time: .shortened))
                        Text(habit.dateLastUpdated.formatted(date: .long, time: .shortened))
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
        habits.habit.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
