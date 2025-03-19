//
//  ContentView.swift
//  Navigation
//
//  Created by Omolemo Mashigo on 2025/03/17.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            List(0..<10){ i in
                NavigationLink("select \(i)", value: i)
            }
            .toolbar{
                Button("push 556"){
                    path.append(556)
                }
            }
            .toolbar{
                Button("push Hello World"){
                    path.append("Hello World")
                }
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
