//
//  ScratchNotesView.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 09/04/26.
//

import SwiftUI

struct ScratchNote: Identifiable {
    let id = UUID()
    var text: String
}

struct ScratchNotesView: View {
    @State private var notes: [ScratchNote] = []
    @State private var selectedNoteID: UUID? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if selectedNoteID != nil {
                    Button(action: {
                        selectedNoteID = nil
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Text("Scratch Notes")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                if selectedNoteID == nil {
                    Button(action: {
                        let newNote = ScratchNote(text: "")
                        notes.insert(newNote, at: 0)
                        selectedNoteID = newNote.id
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, selectedNoteID == nil ? 10 : 0)
            
            if let id = selectedNoteID, let index = notes.firstIndex(where: {$0.id == id}) {
                
                TextEditor(text: $notes[index].text)
                    .scrollContentBackground(.hidden)
                    .font(.body.weight(.light))
                    .foregroundColor(.white.opacity(0.9))
                    .background(Color.clear)
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 150)
            } else {
                if notes.isEmpty {
                    Text("Hit + to scratch")
                        .foregroundColor(.white.opacity(0.2))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .frame(height: 125)
                } else {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 15) {
                            ForEach(notes) { note in
                                ScratchCardView(
                                    note: note,
                                    onEdit: {selectedNoteID = note.id},
                                    onDelete: {notes.removeAll{$0.id == note.id}}
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 125)
                }
            }
        }
        .padding(.bottom, 15)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.black.opacity(0.2))
        )
        .padding(.horizontal, 20)
        .animation(.easeInOut(duration: 0.2), value: selectedNoteID)
    }
}

struct ScratchCardView: View {
    let note: ScratchNote
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    @State private var isHovering = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text(note.text.isEmpty ? "..." : note.text)
                .font(.caption)
                .foregroundColor(.white.opacity(note.text.isEmpty ? 0.3 : 0.7))
                .lineLimit(4)
                .padding(12)
                .frame(width: 150, height: 125, alignment: .topLeading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
            
            if isHovering {
                Color.black.opacity(0.5)
                    .cornerRadius(10)
                
                HStack(spacing: 15) {
                    Button (action: onEdit) {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button (action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red.opacity(0.9))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(width: 150, height: 125)
        .onHover { hovering in
            isHovering = hovering
        }
        .onTapGesture {
            onEdit()
        }
    }
}
