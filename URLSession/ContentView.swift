//
//  ContentView.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var driverData = DriverData()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    Text("drivers by ID: \(driverData.driversByID)")
                }
                .padding()
            }
        }
        .task{
            await driverData.getData()
        }
    }
}

#Preview {
    ContentView()
}
