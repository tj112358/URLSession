//
//  Creatures.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

class Creatures {
    
    var urlString = ""
    
    func getData() async {
        print("Accessing the URL \(urlString)")
        
        //create a url
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //WOULD decode JSON data here...
        } catch {
            print("ERROR: Could not get data from \(url)")
        }
    }
}
