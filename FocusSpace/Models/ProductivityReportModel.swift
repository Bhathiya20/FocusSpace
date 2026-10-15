//
//  ProductivityReportModel.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation

// MARK: - Export Format Types
enum ExportFormat: String, CaseIterable, Identifiable {
    case csv = "CSV"
    case json = "JSON"
    case textSummary = "Text Summary"
    
    var id: String { rawValue }
    var fileExtension: String {
        switch self {
        case .csv: return "csv"
        case .json: return "json"
        case .textSummary: return "txt"
        }
    }
}

// MARK: - Productivity Report Aggregate Model
struct ProductivityReport: Codable, Identifiable {
    var id: UUID = UUID()
    var generatedDate: Date = Date()
    var totalFocusSessions: Int
    var totalFocusMinutes: Int
    var totalTasksCompleted: Int
    var averageSessionMinutes: Double
    var topCategory: String
    var sessions: [FocusSessionRecord]
    
    var formattedTotalDuration: String {
        let hours = totalFocusMinutes / 60
        let minutes = totalFocusMinutes % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }
}
