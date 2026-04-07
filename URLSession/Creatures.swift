//
//  Creatures.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

@Observable
class Creatures {
    
    private struct Returned: Codable {
        var Season: Season
        var Teams: [Teams]
        var OtherSeriesTeamsAndDriversUrls: OtherSeriesTeamsAndDriversUrls
    }
    
    private struct Season: Codable {
        var SeasonId: Int
        var SeasonName: String
        var SeasonStartDate: String
        var SeasonEndDate: String
        var SeasonTypeCode: String
        var HasResultFeed: Bool
    }
    
    private struct Teams: Codable {
        var TeamId: Int
        var TeamFullName: String
        var TLA: String
        var CountryId: Int
        var CountryName: String
        var CountryCode: String
        var Drivers: [Drivers]
        var logoImage: LogoImage
        var carImage: CarImage
    }
    
    private struct Drivers: Codable {
        var DriverId: Int
        var FullName: String
        var DisplayName: String
        var TLA: String
        var CountryId: Int
        var CountryName: String
        var CountryCode: String
        var CarNumber: Int
        var DriverImage: DriverImage
        var Support: String
        var DriverWithoutBackgroundImage: DriverWithoutBackgroundImage
    }
    
    private struct LogoImage: Codable {
        var path: String
        var url: String
    }
    
    private struct CarImage: Codable {
        var path: String
        var url: String
    }
    
    private struct DriverImage: Codable {
        var path: String
        var url: String
    }
    
    private struct DriverWithoutBackgroundImage: Codable {
        var path: String
        var url: String
    }
    
    private struct OtherSeriesTeamsAndDriversUrls: Codable {
        var f1: String
        var f2: String
        var f3: String
    }
    
    
    
    var urlString = "https://api.formula1.com/v1/f2f3-fom-results/teamsanddrivers?website=fa"
    
    func getData() async {
        print("Accessing the URL \(urlString)")
        
        //create a url
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
            request.addValue("7VXRDbwotsJPAYo24rBa6DQClFVGGYP7", forHTTPHeaderField: "Apikey")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
           
            // try to decode JSON here
            
            //VERSION 2: MAPPING
            do {
              let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .custom(<#T##([any CodingKey]) -> any CodingKey##([any CodingKey]) -> any CodingKey##(_ codingPath: [any CodingKey]) -> any CodingKey#>)
              let returned = try? decoder.decode(Returned.self, from: data)
                print("data: \(returned?.Season)")
            } catch {
              print(error)
            }
            
            //VERSION 1: PROF G
//            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
//                print(data)
//                print(response)
//                print("JSON ERROR: Could not decode returned JSON")
//                return
//            }
            print("VICTORY! JSON RETURNED")
            
        } catch {
            print("ERROR: Could not get data from \(url)")
        }
    }
}
