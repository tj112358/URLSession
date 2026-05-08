//
//  StandingsPage.swift
//  URLSession
//
//  Created by Thea Yocum on 5/7/26.
//

//TODO: way to identify drivers by not their abbriviation? needed to be able to find drivers before they are reflected on the standings page... having a "no season yet" could also help prevent against this error, but.... Ideally, this dictionary self updates as well. Also, being unable to access drivers WCD standings, and their number changing over seasons... could be helpful to split the dictionary by year if possible, to demonstrate the driver's WCD status and accurate carno for that year? ugh and team...


import SwiftUI
import SwiftSoup
import SwiftData

struct StandingsPage: View {
    
    @State var standings: [standingsInfo] = [
        standingsInfo(standing: "", firstInitLastName: "", pts: "", tla: "", driverNo: "")
    ]

    var body: some View {
        NavigationView {
            ZStack {
//                Color(.backdrop)
//                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        Text("DRIVERS' STANDINGS")
//                            .foregroundStyle(.typeface)
                            .font(.custom("Formula1-Display-Regular", size: 26))
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                        
                        Grid(alignment: .leading, horizontalSpacing: 1, verticalSpacing: 25){
                            
                            GridRow {
                                Text("POS")
                                    .gridCellColumns(2)
                                Text("DRIVER")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("PTS")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .font(.custom("ProximaNova-Bold", size: 20))
                            
                            
                            //TODO: remove the magic numbers on the for each to prevent "index out of range" crashes
                            ForEach (standings, id: \.self) { driver in
                                let standing = driver.standing
                                let pts = driver.pts
                                let person = driver.firstInitLastName
                                
                                NavigationLink {
                                    //This is what the Navigation link displays (the driver page)
                                    ZStack {
//                                        Color(.backdrop)
//                                            .edgesIgnoringSafeArea(.all)
                                        ScrollView {
//                                            DriverView(driver: queen.histno)
//                                            Statistics(driver: queen.histno)
                                        }
                                    }
                                    
                                } label: {
                                    //This is what the navigation link looks like on the standing's page
                                    GridRow {
                                        Text(standing)
                                            .frame(minWidth: 30, alignment: .leading)
                                            .padding(.leading, 5)
                                        
//                                        AsyncImage(url: URL(string: img)) { image in
//                                            image
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                        } placeholder: {
//                                            ProgressView()
//                                        }
//                                        .frame(width: 40, height: 40)
//                                        .clipShape(Circle())
//                                        .padding(.trailing, 15)

                                        Text(person)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(pts)
                                            .frame(alignment: .trailing)
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(Color(.gray))
                                    }
                                    .font(.custom("Formula1-Display-Regular", size: 14))
                                }
                            }
                        }
                    }
//                    .foregroundStyle(.typeface)
                    .font(.custom("ProximaNova-Medium", size: 15))
                    .frame(maxWidth: .infinity)
                }
                .padding(20)
            }
        }
        .task {
            standings = await scrapeStandings(url: "https://www.f1academy.com/Racing-Series/Standings/Driver?seasonId=4", seasonTotalDrivers: 18)!
        }
    }
}

#Preview {
    StandingsPage()
}
