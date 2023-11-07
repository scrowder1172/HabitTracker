//
//  Habits.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

enum HabitType: Codable {
    case Personal, Business, Health, School
}

struct Habit: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let purpose: String
    let type: HabitType
    let dateAdded: Date
    let dateLastUpdated: Date
}

@Observable
class Habits {
    var habits: [Habit] = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        // return an empty array if previous habits could not be found or loaded
        habits = []
    }
}
