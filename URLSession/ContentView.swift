//
//  ContentView.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI

struct ContentView: View {
    
    var creatures = Creatures()
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
        .task{
            await creatures.getData()
        }
    }
}

#Preview {
    ContentView()
}
