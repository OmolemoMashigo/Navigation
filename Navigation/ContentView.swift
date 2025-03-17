//
//  ContentView.swift
//  Navigation
//
//  Created by Omolemo Mashigo on 2025/03/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List(0..<100){ i in
                NavigationLink("select \(i)", value: i)
            }
            .navigationDestination(for: Int.self){ selection in
                Text("you selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
