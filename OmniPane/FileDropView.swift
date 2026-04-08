//
//  FileDropView.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 08/04/26.
//

import SwiftUI
import QuickLook
import UniformTypeIdentifiers

struct FileDropView: View {
    @State private var files: [URL] = []
    @State private var quickLookURL: URL? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("File Drop")
                .font(.title3)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal)
                .padding(.top, 10)
    
            if files.isEmpty {
                Text("Drag & Drop files to/from here.")
                    .foregroundColor(.white.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .frame(height: 125)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 15) {
                        ForEach(files, id:\.self) {
                            url in FileItemView(url: url) {
                                files.removeAll { $0 == url}
                            } onDoubleTap: {
                                quickLookURL = url
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 100)
            }
        }
        .padding(.bottom, 15)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.black.opacity(0.25))
        )
        .padding(.horizontal, 20)
        .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                    for provider in providers {
                        _ = provider.loadObject(ofClass: URL.self) { url, _ in
                            if let newURL = url {
                                DispatchQueue.main.async {
                                    // Only add if it's not a duplicate
                                    if !files.contains(newURL) {
                                        files.append(newURL)
                                    }
                        }
                    }
                }
            }
            return true
        }
        .quickLookPreview($quickLookURL)
    }
}

struct FileItemView: View {
    let url: URL
    let onDelete: () -> Void
    let onDoubleTap: () -> Void
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Image(nsImage:
                        NSWorkspace.shared.icon(forFile: url.path)
                )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                
                Text(url.lastPathComponent)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .frame(width: 65)
            }
            .padding(8)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .onTapGesture(count: 2) {
                onDoubleTap()
            }
            .onDrag {
                NSItemProvider(object: url as NSURL)
            }
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red.opacity(0.8))
                    .background(Circle().fill(Color.black))
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x: 5, y: -5)
        }
    }
}
