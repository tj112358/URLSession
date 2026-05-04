//
//  Webscraping.swift
//  URLSession
//
//  Created by Thea Yocum on 4/30/26.
//

import SwiftUI
import SwiftSoup

//a: consider embeding inside a class. this means that the data that the func returns is then parsed in the same class
//b: solve these return errors, then .task {await scrapeFromSite(url: ___ )}
//c: not doing this correctly... should just put this code directly in the task block, and save me the trouble of finding the variables?


func scrapeFromSite(url: String) async -> Document? {
    
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
        
        return myDocument
        
    } catch {
        print("ERROR: Could not get data from \(url)")
        return nil
    }
}
