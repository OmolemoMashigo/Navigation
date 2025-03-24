//
//  ContentView.swift
//  Navigation
//
//  Created by Omolemo Mashigo on 2025/03/17.
//

import SwiftUI

@Observable
class PathStore{
    var path: NavigationPath{
        //when the path is changes, we call the save() method
        didSet{
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    //the init loads data from disk and puts it into the path array
    init(){
        if let data = try? Data(contentsOf: savePath){//load data
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data){
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()//empty NavigationPath if loading and decoding path did not work
    }
    
    //function writes the Codable representation of our NavigationPath
    func save(){
        
        guard let representation = path.codable else {return}
        do{
            let data = try? JSONEncoder().encode(representation)
            try data?.write(to: savePath) //write data out to savePath
            
        }catch{
            print("failed to save navigation data")
        }
    }
}
struct DetailView: View{
    var number: Int
    @State private var title = "SwiftUI"
    
    var body: some View{
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
        
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
