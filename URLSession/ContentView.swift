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
    @State var myDocument : Document = Document("")

    var body: some View {
        @State var headline = try! myDocument.select("div.row div.article-listing-card--item:eq(4) .font-text-body")

        NavigationStack{
            ScrollView {
                VStack {
                    Text("Headline 1: \(try! headline.text())")
                }
                .padding()
            }
        }
        .task{
            myDocument = await scrapeFromSite(url: "https://www.f1academy.com/Latest")!
        }
    }
}

#Preview {
    ContentView()
}
