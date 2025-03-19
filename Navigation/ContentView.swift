//
//  ContentView.swift
//  Navigation
//
//  Created by Omolemo Mashigo on 2025/03/17.
//

import SwiftUI

struct DetailView: View{
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View{
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("number: \(number)")
            .toolbar{
                Button("Home"){
                    path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self){ i in
                    DetailView(number: i, path: $path)
                }
        }
    }
}

#Preview {
    ContentView()
}
