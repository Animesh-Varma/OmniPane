//
//  ContentView.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 08/04/26.
//

import SwiftUI

struct ContentView: View {
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
        }
        .frame(minWidth: 300, maxWidth: 700, minHeight: 400)
        .navigationTitle("OmniPane").font(.headline).foregroundStyle(Color.white.opacity(0.8))
    }
}

