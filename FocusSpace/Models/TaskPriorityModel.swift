//
//  TaskPriorityModel.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation
import SwiftUI

// MARK: - Task Priority Level
enum TaskPriority: String, CaseIterable, Codable, Comparable, Identifiable {
    case urgent = "Urgent"
    case high = "High"
    case medium = "Medium"
    case low = "Low"
    
    var id: String { rawValue }
    
    var sortOrder: Int {
        switch self {
        case .urgent: return 0
        case .high: return 1
        case .medium: return 2
        case .low: return 3
        }
    }
    
    static func < (lhs: TaskPriority, rhs: TaskPriority) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
    
    var color: Color {
        switch self {
        case .urgent:
            return FocusSpaceTheme.coralWarning
        case .high:
            return FocusSpaceTheme.amberPending
        case .medium:
            return FocusSpaceTheme.goldPrimary
        case .low:
            return FocusSpaceTheme.emeraldSuccess
        }
    }
    
    var iconName: String {
        switch self {
        case .urgent:
            return "exclamationmark.3"
        case .high:
            return "arrow.up.circle.fill"
        case .medium:
            return "minus.circle.fill"
        case .low:
            return "arrow.down.circle.fill"
        }
    }
}

// MARK: - Task Tag Model
struct TaskTag: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var hexColor: String
    
    static let defaultTags: [TaskTag] = [
        TaskTag(name: "Sprint", hexColor: "#F2CC7B"),
        TaskTag(name: "Research", hexColor: "#BA93FC"),
        TaskTag(name: "Review", hexColor: "#7BC9A4"),
        TaskTag(name: "Bugfix", hexColor: "#E88787")
    ]
}
