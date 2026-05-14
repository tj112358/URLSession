//
//  ScrapeNews.swift
//  URLSession
//
//  Created by Thea Yocum on 4/30/26.
//

import SwiftUI
import SwiftSoup

//a: consider embeding inside a class. this means that the data that the func returns is then parsed in the same class
//b: solve these return errors, then .task {await scrapeFromSite(url: ___ )}
//c: not doing this correctly... should just put this code directly in the task block, and save me the trouble of finding the variables?


func scrapeNews() async -> Array<newsCard>? {
    
    let urlString = "https://www.f1academy.com/Latest"
    
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
        var news = [newsCard]()
        
        for i in 0...19 {
            let headline = try! myDocument.select("div.row div.article-listing-card--item:eq(\(i)) .font-text-body")
            let title = try! myDocument.select("div.row div.article-listing-card--item:eq(\(i)) .font-tag")
            let address = try! myDocument.select("div.row div.article-listing-card--item:eq(\(i)) a")
            let addressNew = ("https://www.f1academy.com" + "\(try! address.attr("href"))")
            let image = try! myDocument.select("div.row div.article-listing-card--item:eq(\(i)) a div.f1-cc--image img.f1-cc--photo")
            let imageNew = "\(try! image.attr("data-src"))"
            
            news.append(newsCard(headline: "\(try! headline.text())", title: "\(try! title.text())", image: imageNew, address: addressNew))
        }
//        print(news)
        return news
        
    } catch {
        print("ERROR: Could not get data from \(url)")
        return nil
    }
}
