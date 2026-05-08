////
////  DriverView.swift
////  URLSession
////
////  Created by Thea Yocum on 5/8/26.
////
//import SwiftUI
//import SwiftSoup
//
//struct DriverView: View {
//    @Environment(\.modelContext) var modelContext
//    let driver : String
//    @Query var myDrivers: [Queen]
//    
//    var body: some View {
//        let queenInQuestion = myDrivers.first(where: { $0.histno == driver })
//                                              
//        let firstName = queenInQuestion!.firstName
//        let lastName = queenInQuestion!.lastName
//        
//        let imageNew = queenInQuestion!.image
//        
//        let flagNew = queenInQuestion!.flag
//        let carno = queenInQuestion!.carno
//        
//        ScrollView {
//            ZStack {
//                Color(.backdrop)
//                    .edgesIgnoringSafeArea(.all)
//                ScrollView {
//                    VStack (spacing: 0) {
//                        
//                        //This is the biopic at the top and the nameing
//                        ZStack{
//                            GeometryReader { proxy in
//                                AsyncImage(url: URL(string: imageNew)) { image in
//                                    image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                                //TODO: fix magic number
//                                .frame(width: proxy.size.width, height: 285) //275
//                            }
//                            VStack{
//                                Spacer()
//                                VStack{
//                                    Text(firstName)
//                                        .foregroundColor(.white)
//                                        .font(.custom("Formula1-Display-Regular", size: 20))
//                                    Text(lastName .uppercased())
//                                        .font(.custom("Formula1-Display-Regular", size: 30))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                    HStack {
//                                        AsyncImage(url: URL(string: flagNew)) { image in
//                                            image
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                        } placeholder: {
//                                            ProgressView()
//                                        }
//                                        .frame(width: 50, height: 33)
//                                        
//                                        Text(carno)
//                                            .font(.custom("Formula1-Display-Regular", size: 30))
//                                            .foregroundColor(.white)
//                                    }
//                                }
//                                .padding(.top, 163) //TODO: fix this magic number
//                                .padding(.bottom, 10)
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [.clear, .paleGray]), startPoint: .top, endPoint: .bottom)
//                                )
//                            }
//                        }
//                        
//                        HStack {
//                            Spacer()
//                            Text("Statistics")
//                            Spacer()
//                            Text("Biography")
//                            Spacer()
//                            Text("Results")
//                            Spacer()
//                        }
//                        .font(.custom("Formula1-Display-Regular", size: 16))
//                        .foregroundColor(.typeface)
//                        .frame(maxWidth: .infinity)
//                        .padding(10)
//                        .background(
//                            .card)
//                        
////                        Statistics(driver: driver)
////                            .id("Stats")
////                        Biography(driver: driver)
////                            .id("Bio")
////                        Results()
////                            .id("Res")
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct Statistics: View {
//    
//    let driver : String
//
//    var body: some View {
//        VStack {
//            Text("2025 SEASON")
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                .padding()
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//            //TODO: make the padding look more aligned, while not using specific pixel sizes
//            Grid(alignment: .leading){
//                GridRow {
//                    Text("Season Position")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("Season Points")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                GridRow {
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                GridRow {
//                    Text("Team")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("Supported By")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                GridRow {
//                    Text("TEAM")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                        .padding(.bottom, 5)
//                    Text("TEAM")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .font(.custom("Formula1-Display-Bold", size: 15))
//                Divider()
//                GridRow {
//                    Text("Podiums")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("Poles")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                GridRow {
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                GridRow {
//                    Text("R1 Wins")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("R2 Wins")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                GridRow {
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                GridRow {
//                    Text("Top 10s")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("DNFs")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                GridRow {
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                        .padding(.bottom, 5)
//                    Text("00")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                Divider()
//            }
//            
//            Text("CAREER STATS")
//                .font(.custom("Formula1-Display-Bold", size: 20))
//                .padding()
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//            Grid(alignment: .leading){
//                GridRow {
//                    Text("Career Points")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("Highest Race Finish")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00 (x00)")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                        .padding(.trailing, 40)
//                    
//                }
//                GridRow {
//                    Text("Podiums")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("Poles")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("DNFs")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("Races Entered")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("Seasons Entered")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//                GridRow {
//                    Text("Wildcard Entries")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 10)
//                        .padding(.top, 5)
//                        .padding(.bottom, 5)
//                    Text("00")
//                        .font(.custom("Formula1-Display-Bold", size: 20))
//                }
//            }
//            .padding(.bottom)
//        }
//    }
//}
//
////struct Biography: View {
////
////    let driver: Driver
////
////    var body: some View {
////        //        let url = URL (string: "https://www.f1academy.com/Racing-Series/Drivers")!
////        //        let html = try? String(contentsOf: url, encoding: .utf8)
////        //        let document = try! SwiftSoup.parse(html ?? "")
////        //
////        //        let firstName = try! document.select("div.row div.teams-driver-item:eq(\(driver.personValue)) .first-name")
////        //         let lastName = try! document.select("div.row div.teams-driver-item:eq(\(driver.personValue)) div.last-name span")
////        //         let number = try! document.select("div.row div.teams-driver-item:eq(\(driver.personValue)) .driver-carno")
////
////        Divider()
////        Text("BIOGRAPHY")
////            .font(.custom("Formula1-Display-Bold", size: 20))
////            .padding()
////            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
////
////        Grid(alignment: .leading) {
////            GridRow {
////                Text("Date of Birth")
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(.leading, 10)
////                    .padding(.top, 5)
////                Text("Place of Birth")
////                    .frame(maxWidth: .infinity, alignment: .leading)
////            }
////            GridRow {
////                Text("00/00/00")
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(.leading, 10)
////                    .padding(.top, 5)
////                Text("Hesselt, Belgium")
////                    .frame(maxWidth: .infinity, alignment: .topLeading)
////            }
////            .font(.custom("Formula1-Display-Bold", size: 15))
////            .padding(.bottom, 5)
////        }
////
////        Text(
////             """
////Enamoured by the sights of Formula 1 on a family holiday, Nicole Havrda was inspired to begin her own racing journey and can’t wait to make her own mark on a Grand Prix weekend in 2025.
////
////Hailing from Comox, British Columbia, the Canadian started off in karting in 2019. After achieving first place in the Calgary Shootout, she went on to be crowned the Vice Champion in the Junior Rotax Challenge Grand Finals in 2021.
////
////Making her open-wheel debut the following year, Havrda earned two top-five finishes in the Indian Racing League Championship and was the youngest of nine finalists for the Aston Martin GT4 female shootout by The Heart of Racing team. Enjoying further success in 2023, she netted three titles in the Formula Pro USA Winter Series, SFR FA2 and became the first female Formula Pro USA Champion.
////
////Progressing up to the Formula Regional Americas Championship, Havrda put together an impressive rookie campaign, finishing sixth overall with four podium finishes.
////
////Teaming up with F1 ACADEMY Official Partner American Express this season, she’ll be getting behind the wheel of the #2 car operated by Hitech TGR. Away from the racetrack, the 19-year-old keeps up the competitive spirit as a downhill ski racer and a swimmer and was featured in a documentary called “The Car Knows No Difference”, which focuses on women in motorsports.
////"""
////        ) //bioooo
////        .padding(15)
////
////        HStack {
////            Link("Driver Website", destination: URL(string: "https://nicolehavrda.com/")!)
////                .padding(10)
////                .background(.hotrodPink)
////                .foregroundColor(.white)
////                .clipShape(Capsule())
////
////            Link(destination: URL(string: "https://www.instagram.com/nicole.havrda?igsh=MWQ5YndmYmxncmN5dQ==")!){
////                Image("instaicon")
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
////                    .frame(width: 30, height: 30)
////                    .padding(5)
////                    .background(.hotrodPink)
////                    .clipShape(Capsule())
////            }
////
////            Link(destination: URL(string: "https://www.youtube.com/@nicole.havrd")!){
////                Image("youtubeicon")
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
////                    .frame(width: 35, height: 35)
////                    .padding(2.5)
////                    .background(.hotrodPink)
////                    .clipShape(Capsule())
////            }
////        }
////        .padding(.bottom)
////    }
////}
////
////struct Results: View {
////    var body: some View {
////        Divider()
////        Text("RESULTS")
////            .font(.custom("Formula1-Display-Bold", size: 20))
////            .padding()
////            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
////
////        Grid(alignment: .leading) {
////            GridRow {
////                Text("Round")
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(.leading, 10)
////                    .padding(.top, 5)
////                Text("Race")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                Text("POS")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                Text("PTS")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                    .padding(.trailing, 10)
////            }
////            .font(.custom("Formula1-Display-Bold", size: 15))
////            .padding(.bottom, 5)
////            //TODO: would be a for each around here, to make a row for each result
////            GridRow {
////                Text("Singapore")
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(.leading, 10)
////                    .padding(.top, 5)
////                Text("X")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                Text("XX")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                Text("XX")
////                    .frame(maxWidth: .infinity, alignment: .trailing)
////                    .padding(.trailing, 10)
////            }
////        }
////    }
////}
//
////#Preview("Main Page") {
////    StandingsPage(queen: Queen())
////        .modelContainer(for: Queen.self, inMemory: true)
////        .preferredColorScheme(.dark)
////}
//
////#Preview("Driver View") {
////    DriverView(driver: Driver(personValue: 9, name: ""))
////}
