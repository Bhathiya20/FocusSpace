//
//  PriorityBadgeView.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import SwiftUI

struct PriorityBadgeView: View {
    let priority: TaskPriority
    var showLabel: Bool = true
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: priority.iconName)
                .font(.caption2)
            
            if showLabel {
                Text(priority.rawValue)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(priority.color.opacity(0.18))
        .foregroundColor(priority.color)
        .cornerRadius(FocusSpaceTheme.chipRadius)
        .overlay(
            RoundedRectangle(cornerRadius: FocusSpaceTheme.chipRadius)
                .stroke(priority.color.opacity(0.35), lineWidth: 1)
        )
    }
}

struct TagFilterBar: View {
    let tags: [TaskTag]
    @Binding var selectedTagId: UUID?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button(action: { selectedTagId = nil }) {
                    Text("All Tags")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(selectedTagId == nil ? FocusSpaceTheme.goldPrimary.opacity(0.2) : FocusSpaceTheme.charcoal700)
                        .foregroundColor(selectedTagId == nil ? FocusSpaceTheme.goldPrimary : .gray)
                        .cornerRadius(FocusSpaceTheme.chipRadius)
                }
                .buttonStyle(.plain)
                
                ForEach(tags) { tag in
                    let isSelected = selectedTagId == tag.id
                    Button(action: {
                        selectedTagId = isSelected ? nil : tag.id
                    }) {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color(hex: tag.hexColor))
                                .frame(width: 6, height: 6)
                            Text(tag.name)
                                .font(.caption)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(isSelected ? FocusSpaceTheme.goldPrimary.opacity(0.2) : FocusSpaceTheme.charcoal700)
                        .foregroundColor(isSelected ? .white : .gray)
                        .cornerRadius(FocusSpaceTheme.chipRadius)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// Hex Color helper
private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 242, 204, 123)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
