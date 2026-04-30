//
//  Creatures.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

@Observable
class DriverData {
    
    struct Returned: Codable {
        var season: Season
        var teams: [Team]
        var otherSeriesTeamsAndDriversUrls: OtherSeriesTeamsAndDriversUrls

        enum CodingKeys: String, CodingKey {
            case season = "Season"
            case teams = "Teams"
            case otherSeriesTeamsAndDriversUrls = "OtherSeriesTeamsAndDriversUrls"
        }
    }

    struct OtherSeriesTeamsAndDriversUrls: Codable {
        var f1, f2, f3: String
    }

    struct Season: Codable {
        var seasonID: Int
        var seasonName, seasonStartDate, seasonEndDate, seasonTypeCode: String
        var hasResultFeed: Bool

        enum CodingKeys: String, CodingKey {
            case seasonID = "SeasonId"
            case seasonName = "SeasonName"
            case seasonStartDate = "SeasonStartDate"
            case seasonEndDate = "SeasonEndDate"
            case seasonTypeCode = "SeasonTypeCode"
            case hasResultFeed = "HasResultFeed"
        }
    }

    struct Team: Codable {
        var teamID: Int
        var teamFullName, tla: String
        var countryID: Int
        var countryName, countryCode: String
        var drivers: [Driver]
        var logoImage, carImage: Image

        enum CodingKeys: String, CodingKey {
            case teamID = "TeamId"
            case teamFullName = "TeamFullName"
            case tla = "TLA"
            case countryID = "CountryId"
            case countryName = "CountryName"
            case countryCode = "CountryCode"
            case drivers = "Drivers"
            case logoImage, carImage
        }
    }

    struct Image: Codable {
        var path: String
        var url: String
    }

    struct Driver: Codable {
        var driverID: Int
        var fullName, displayName, tla: String
        var countryID: Int
        var countryName, countryCode: String
        var carNumber: Int
        var driverImage: Image
        var support: String
        var driverWithoutBackgroundImage: Image

        enum CodingKeys: String, CodingKey {
            case driverID = "DriverId"
            case fullName = "FullName"
            case displayName = "DisplayName"
            case tla = "TLA"
            case countryID = "CountryId"
            case countryName = "CountryName"
            case countryCode = "CountryCode"
            case carNumber = "CarNumber"
            case driverImage, support, driverWithoutBackgroundImage
        }
    }
// MARK: build new data structure here, where variable names make sense...
    var teams: [Team] = []
    var teamID: Int = 0
    
    
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
            let (data, _) = try await URLSession.shared.data(for: request)
           
            // try to decode JSON here
            
//            VERSION 1: PROF G
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON")
                return
            }
// MARK: other half of returned data formatting
            
            self.teams = returned.teams
            self.teamID = returned.teams[0].teamID
            
            print("VICTORY! JSON RETURNED")
            
        } catch {
            print("ERROR: Could not get data from \(url)")
        }
    }
}
