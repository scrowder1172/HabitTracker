//
//  Habits.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

enum HabitType: String, Codable, CaseIterable {
    case personal = "Personal"
    case health = "Health"
    case school = "School"
    case work = "Work"
}

struct HabitItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let purpose: String
    let type: HabitType
    let targetDate: Date
    let dateAdded: Date
    let dateLastUpdated: Date
}

@Observable
class Habits: Identifiable {
    var habit: [HabitItem] = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habit) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([HabitItem].self, from: savedHabits) {
                habit = decodedHabits
                return
            }
        }
        
        // return an empty array if previous habits could not be found or loaded
        habit = []
    }
}
