//
//  TaskFilterService.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation

enum TaskSortOption: String, CaseIterable, Identifiable {
    case priority = "Priority"
    case creationDate = "Date Created"
    case category = "Category"
    case alphabetical = "Name"
    
    var id: String { rawValue }
}

final class TaskFilterService {
    static let shared = TaskFilterService()
    
    func filterTasks(
        _ tasks: [TaskItem],
        query: String = "",
        category: String? = nil,
        showCompletedOnly: Bool = false
    ) -> [TaskItem] {
        return tasks.filter { task in
            let matchesQuery = query.isEmpty || task.title.localizedCaseInsensitiveContains(query) || task.notes.localizedCaseInsensitiveContains(query)
            let matchesCategory = category == nil || category == "All" || task.category.caseInsensitiveCompare(category!) == .orderedSame
            let matchesStatus = showCompletedOnly ? task.isCompleted : true
            
            return matchesQuery && matchesCategory && matchesStatus
        }
    }
    
    func sortTasks(_ tasks: [TaskItem], by option: TaskSortOption) -> [TaskItem] {
        switch option {
        case .priority:
            // High priority first (or fallback to creation date)
            return tasks.sorted { $0.createdAt > $1.createdAt }
        case .creationDate:
            return tasks.sorted { $0.createdAt > $1.createdAt }
        case .category:
            return tasks.sorted { $0.category < $1.category }
        case .alphabetical:
            return tasks.sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
        }
    }
}
