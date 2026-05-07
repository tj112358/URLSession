//
//  ContentView.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    
    @State var driverData = DriverData()
    @State var news: [Any] = []

    var body: some View {

        NavigationStack{
            ScrollView {
                VStack {
                    Text("Headline 1: \(news)")
                }
                .padding()
            }
        }
        .task {
            news = await scrapeNews()!
        }
    }
}

#Preview {
    ContentView()
}
