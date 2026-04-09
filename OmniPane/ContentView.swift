//
//  ContentView.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 08/04/26.
//

import SwiftUI
import UniformTypeIdentifiers

enum AppUtility: String, CaseIterable, Identifiable {
    case fileDrop = "File Drop"
    case scratchNotes = "Scratch Notes"
    var id: String {self.rawValue}
}

struct ContentView: View {
    @AppStorage("showFileDrop") private var showFileDrop = true
    @AppStorage("showScratchNotes") private var showScratchNotes = true
    @AppStorage("moduleOrder") private var orderString = "fileDrop,scratchNotes"

    @State private var activeOrder: [AppUtility] = []

    var body: some View {
        ZStack {
            // AI Written gradient -- feeling lazy :\
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 19/255, green: 63/255, blue: 15/255).opacity(1),
                    Color(red: 7/255, green: 25/255, blue: 6/255).opacity(1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    ForEach(activeOrder) { utility in
                        if utility == .fileDrop && showFileDrop {
                            UtilityWrapper(item: utility, list: $activeOrder) {
                                FileDropView()
                                    .padding(.top, 5)
                            }
                        } else if utility == .scratchNotes && showScratchNotes {
                            UtilityWrapper(item: utility, list: $activeOrder) {
                                ScratchNotesView()
                                    .padding(.top, 5)
                            }
                        }
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 20)
            }
        }
        .frame(minWidth: 300, maxWidth: 700, minHeight: 400)
//        .navigationTitle("OmniPane").font(.headline).foregroundStyle(Color.white.opacity(0.8))
        .onAppear {loadOrder()}
        .onChange(of: activeOrder) {_ in saveOrder()}
    }
    
    private func loadOrder() {
        let saved = orderString.components(separatedBy: ",")
        
        activeOrder = saved.compactMap {
            AppUtility(rawValue: $0)
        }
        
        for utility in AppUtility.allCases {
            if !activeOrder.contains(utility) {
                activeOrder.append(utility)
            }
        }
    }
    private func saveOrder() {
        orderString = activeOrder.map {$0.rawValue}.joined(separator: ",")
    }
}

struct UtilityWrapper<Content: View>: View {
    let item: AppUtility
    @Binding var list: [AppUtility]
    
    let content: Content
    
    init(item: AppUtility,
        list: Binding<[AppUtility]>,
        @ViewBuilder content: () -> Content
    ) {
        self.item = item
        self._list = list
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            content
            
            Image(systemName: "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.white.opacity(0.2))
                .padding(25)
                .onDrag {
                    return NSItemProvider(object: item.rawValue as NSString)
                }
        }
        .onDrop(of: [.plainText], delegate:
            ReorderDelegate(item: item, list: $list))
    }
}

struct ReorderDelegate: DropDelegate {
    let item: AppUtility
    @Binding var list: [AppUtility]
    
    func dropEntered(info: DropInfo) {
        guard info.hasItemsConforming(to: [.plainText])
        else { return }
        
        let draggedItem = info.itemProviders(for: [.plainText]).first
        draggedItem?.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { (data, error) in
            if let data = data as? Data, let draggedString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    guard let draggedUtility = AppUtility(rawValue: draggedString),
                          draggedUtility != item,
                          let fromIndex = list.firstIndex(of: draggedUtility),
                          let toIndex = list.firstIndex(of: item) else {return}
                    
                    withAnimation(.default) {
                        list.move(fromOffsets: IndexSet(integer: fromIndex),
                                  toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
                    }
                }
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}

