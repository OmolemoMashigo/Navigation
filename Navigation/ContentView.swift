//
//  ContentView.swift
//  Navigation
//
//  Created by Omolemo Mashigo on 2025/03/17.
//

import SwiftUI

@Observable
class PathStore{
    var path: [Int]{
        //when the path is changes, we call the save() method
        didSet{
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    //the init loads data from disk and puts it into the path array
    init(){
        if let data = try? Data(contentsOf: savePath){//load data
            if let decoded = try? JSONDecoder().decode([Int].self, from: data){
                path = decoded
                return
            }
        }
        path = []//empty path if loading and decoding path did not work
    }
    
    func save(){
        do{
            let data = try? JSONEncoder().encode(path)
            try data?.write(to: savePath) //write data out to savePath
            
        }catch{
            print("failed to save navigation data")
        }
    }
}
struct DetailView: View{
    var number: Int
    
    var body: some View{
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("number: \(number)")
        
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path){
            DetailView(number: 0)
                .navigationDestination(for: Int.self){ i in
                    DetailView(number: i)
                }
        }
    }
}

#Preview {
    ContentView()
}
