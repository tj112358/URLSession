//
//  ContentView.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    
    @State var news: [Any] = []
    @State var standings: [Any] = []
    @State var myDriver: Any = ""

    var body: some View {

        NavigationStack{
            ScrollView {
                VStack {
//                    Text("Headline 1: \(news)")
//                    Text("driverData: \(driverData.driversByID)")
//                    Text("standings: \(standings)")
                    Text("my driver: \(myDriver)")
                }
                .padding()
            }
        }
        .task {
            news = await scrapeNews()!
            standings = await scrapeStandings(url: "https://www.f1academy.com/Racing-Series/Standings/Driver?seasonId=4", seasonTotalDrivers: 18)!
            myDriver = await scrapeDrivers(tla: 40)
        }
    }
}

#Preview {
    ContentView()
}
