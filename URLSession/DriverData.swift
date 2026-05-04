//
//  DriverData.swift
//  URLSession
//
//  Created by Thea Yocum on 4/6/26.
//

import SwiftUI
import SwiftSoup

@Observable
class DriverData {
    // images are commented out because they like to make problems with the JSON decoding, and anyways, I don't need them.
    struct Returned: Codable, Hashable {
        var season: Season
        var teams: [Team]
        var otherSeriesTeamsAndDriversUrls: OtherSeriesTeamsAndDriversUrls

        enum CodingKeys: String, CodingKey {
            case season = "Season"
            case teams = "Teams"
            case otherSeriesTeamsAndDriversUrls = "OtherSeriesTeamsAndDriversUrls"
        }
    }

    struct OtherSeriesTeamsAndDriversUrls: Codable, Hashable {
        var f1, f2, f3: String
    }

    struct Season: Codable, Hashable {
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

    struct Team: Codable, Hashable {
        var teamID: Int
        var teamFullName, tla: String
        var countryID: Int
        var countryName, countryCode: String
        var drivers: [Driver]
//        var logoImage, carImage: String

        enum CodingKeys: String, CodingKey {
            case teamID = "TeamId"
            case teamFullName = "TeamFullName"
            case tla = "TLA"
            case countryID = "CountryId"
            case countryName = "CountryName"
            case countryCode = "CountryCode"
            case drivers = "Drivers"
//            case logoImage, carImage
        }
    }

    struct Image: Codable {
        var path: String
        var url: String
    }

    struct Driver: Codable, Hashable {
        var driverID: Int
        var fullName, displayName, tla: String
        var countryID: Int
        var countryName, countryCode: String
        var carNumber: Int
//        var driverImage: String
        var support: String
//        var driverWithoutBackgroundImage: String

        enum CodingKeys: String, CodingKey {
            case driverID = "DriverId"
            case fullName = "FullName"
            case displayName = "DisplayName"
            case tla = "TLA"
            case countryID = "CountryId"
            case countryName = "CountryName"
            case countryCode = "CountryCode"
            case carNumber = "CarNumber"
            case support
//            case driverImage, support, driverWithoutBackgroundImage
        }
    }
// MARK: initialize the variables by which to select data in contentView here
    var driversByID = [String : Int]()
    
    
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
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON")
                return
            }
            
// MARK: other half of formatting the returned data
            //make dictionary of tla to driverID
            for team in returned.teams {
                for driver in team.drivers {
                    driversByID.updateValue(driver.driverID, forKey: driver.tla)
                }
            }
            
            self.driversByID = driversByID
            
            print("VICTORY! JSON RETURNED")
            
        } catch {
            print("ERROR: Could not get data from \(url)")
        }
    }
}
