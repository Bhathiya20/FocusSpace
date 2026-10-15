//
//  FocusSessionExportService.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation

final class FocusSessionExportService {
    static let shared = FocusSessionExportService()
    
    func generateCSV(from sessions: [FocusSessionRecord]) -> String {
        var csv = "Session ID,Title,Duration (Minutes),Date,Time Formatted,Task Title\n"
        let dateFormatter = ISO8601DateFormatter()
        
        for session in sessions {
            let row = [
                session.id.uuidString,
                "\"\(session.title.replacingOccurrences(of: "\"", with: "\"\""))\"",
                "\(session.durationMinutes)",
                dateFormatter.string(from: session.timestamp),
                session.timeFormatted,
                "\"\(session.taskTitle?.replacingOccurrences(of: "\"", with: "\"\"") ?? "")\""
            ].joined(separator: ",")
            csv.append(row + "\n")
        }
        return csv
    }
    
    func generateJSON(from sessions: [FocusSessionRecord]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        
        guard let data = try? encoder.encode(sessions),
              let string = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return string
    }
    
    func generateSummary(report: ProductivityReport) -> String {
        return """
        ==================================================
                    FOCUSSPACE PRODUCTIVITY REPORT        
        ==================================================
        Generated: \(report.generatedDate.formatted(date: .abbreviated, time: .shortened))
        Total Sessions: \(report.totalFocusSessions)
        Total Time Focused: \(report.formattedTotalDuration)
        Avg Session: \(String(format: "%.1f", report.averageSessionMinutes)) mins
        Completed Tasks: \(report.totalTasksCompleted)
        Top Focus Category: \(report.topCategory)
        ==================================================
        """
    }
}
