//
//  ExportSummarySheet.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import SwiftUI

struct ExportSummarySheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = FocusSpaceStore.shared
    @State private var selectedFormat: ExportFormat = .csv
    @State private var exportedString: String = ""
    @State private var isCopied: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header Title
                Text("Export Focus Data")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(FocusSpaceTheme.goldPrimary)
                    .padding(.top, 16)
                
                // Format Picker
                Picker("Export Format", selection: $selectedFormat) {
                    ForEach(ExportFormat.allCases) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .onChange(of: selectedFormat) { _ in
                    generateExportContent()
                }
                
                // Preview Area
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Export Preview")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(store.completedSessions.count) sessions included")
                            .font(.caption2)
                            .foregroundColor(FocusSpaceTheme.goldPrimary)
                    }
                    
                    ScrollView {
                        Text(exportedString.isEmpty ? "No sessions recorded yet." : exportedString)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                    }
                    .frame(maxHeight: 220)
                    .background(FocusSpaceTheme.charcoal850)
                    .cornerRadius(FocusSpaceTheme.cardRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: FocusSpaceTheme.cardRadius)
                            .stroke(FocusSpaceTheme.glassBorder, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Actions
                VStack(spacing: 12) {
                    Button(action: {
                        #if os(iOS) || os(visionOS)
                        UIPasteboard.general.string = exportedString
                        isCopied = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isCopied = false
                        }
                        #endif
                    }) {
                        HStack {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc.fill")
                            Text(isCopied ? "Copied to Clipboard!" : "Copy \(selectedFormat.rawValue) to Clipboard")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(FocusSpaceTheme.charcoal900)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(isCopied ? FocusSpaceTheme.emeraldSuccess : FocusSpaceTheme.goldPrimary)
                        .cornerRadius(FocusSpaceTheme.buttonRadius)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .background(FocusSpaceTheme.charcoal900)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                generateExportContent()
            }
        }
    }
    
    private func generateExportContent() {
        let exportService = FocusSessionExportService.shared
        switch selectedFormat {
        case .csv:
            exportedString = exportService.generateCSV(from: store.completedSessions)
        case .json:
            exportedString = exportService.generateJSON(from: store.completedSessions)
        case .textSummary:
            let report = ProductivityReport(
                totalFocusSessions: store.completedSessions.count,
                totalFocusMinutes: store.completedSessions.reduce(0) { $0 + $1.durationMinutes },
                totalTasksCompleted: store.tasks.filter { $0.isCompleted }.count,
                averageSessionMinutes: store.completedSessions.isEmpty ? 0 : Double(store.completedSessions.reduce(0) { $0 + $1.durationMinutes }) / Double(store.completedSessions.count),
                topCategory: "Study",
                sessions: store.completedSessions
            )
            exportedString = exportService.generateSummary(report: report)
        }
    }
}
