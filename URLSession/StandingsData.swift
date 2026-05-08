//
//  Webscraping.swift
//  URLSession
//
//  Created by Thea Yocum on 4/30/26.
//

import SwiftUI
import SwiftSoup

struct standingsInfo: Hashable {
    var standing: String
    var firstInitLastName: String
    var pts: String
    var tla: String
    var driverNo: String
}
    

func scrapeStandings(url: String, seasonTotalDrivers: Int) async -> Array<standingsInfo>? {
    
    @State var driverData = DriverData()
    
    let seasonTotalDrivers = seasonTotalDrivers
    let urlString = url
    
    print("Accessing the URL \(urlString)")
    
    //create a url from the URLstring
    guard let url = URL(string: urlString) else {
        print("ERROR: Could not create a URL from \(urlString)")
        return nil
    }
    
    //create a URLsession request
    let request = URLRequest(url: url)
    
    do {
        //create a data variable that holds the awaited for urldata
        let (data, _) = try await URLSession.shared.data(for: request)
        
        //create an html from the data
        guard let html = String(data: data, encoding: .utf8) else {
            print("SWIFTSOUP ERROR: Could not create html from url")
            return nil
        }
        
        //parse the html into a document with swift soup
        guard let myDocument = try? SwiftSoup.parse(html) else {
            print("SWIFTSOUP ERROR: Could not create html from url")
            return nil
        }
        
        //create the newsArray with the scraped document, and return the news
        var standings = [standingsInfo]()
        
        //call the driverData function to start accessing the JSON
        await driverData.getData()
        
        for i in 0...seasonTotalDrivers-1 {
            let standing = try! myDocument.select("tbody tr:eq(\(i)) .pos")
            let pts = try! myDocument.select("tbody tr:eq(\(i)) .total-points")
            let firstInitLastName = try! myDocument.select("tbody tr:eq(\(i)) .visible-desktop-up")
            let tla = try! myDocument.select("tbody tr:eq(\(i)) .visible-desktop-down")
            let driverNo = driverData.driversByID[String(try! tla.text())]
            
            //update the array, with 1000 as a default value... this shouldn't happen btw
            standings.append(standingsInfo(standing: String(try! standing.text()), firstInitLastName: String(try! firstInitLastName.text()), pts: String(try! pts.text()), tla: String(try! tla.text()), driverNo: String(driverNo ?? 1000)))
        }
        return standings
        
    } catch {
        print("ERROR: Could not get data from \(url)")
        return nil
    }
}
