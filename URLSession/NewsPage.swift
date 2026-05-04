//
//  NewsPage.swift
//  app2
//
//  Created by Thea Yocum on 9/18/25.
//

import SwiftUI
import WebKit
import SwiftSoup

//TODO: add instagram moments style on homepage
//TODO: loading page

struct headline2: View {
    var headline: String
    var title: String
    var img: String
    var address: String
    
    var body: some View {
        NavigationLink(destination: WebView(url: URL(string: address))) {
            VStack(alignment: .leading, spacing: 20.0){
                HStack{
                    AsyncImage(url: URL(string: img)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 90)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, bottomLeading: 15)))
                    
                    VStack(alignment: .leading){
                        Text(title .uppercased())
//                            .foregroundColor(.typeface)
                            .font(.system(size: 12))
                        Text(headline)
                            .font(.custom("Formula1-Display-Bold", size: 14))
                            .fontWeight(.bold)
//                            .foregroundColor(.typeface)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading, 5)
                    .padding(.trailing, 10)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                }
            }
            .background(Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity)
                .cornerRadius(15)
//                .foregroundColor(.card)
                        //.shadow(radius: 5)
            )
            .padding(.top, 5)
            .padding(.horizontal)
        }
    }
}

struct headliner: View {
    var headline: String
    var title: String
    var img: String
    var address: String
    
    var body: some View{
        //TODO: load pages and text in app rather than webkit view?
        NavigationLink(destination: WebView(url: URL(string: address))) {
            ZStack{
                AsyncImage(url: URL(string: img)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(15)
                
                VStack{
                    Spacer()
                    VStack(alignment: .leading){
                        Text(title.uppercased())
                            .foregroundColor(.white)
                            .font(.custom("ProximaNova-Medium", size: 15))
                            
                        Text(headline)
                            .font(.custom("Formula1-Display-Bold", size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .padding(.top, 40)
                    .background(Rectangle()
//                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, .paleGray]), startPoint: .top, endPoint: .bottom))
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 15, bottomTrailing: 15)))
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 5)
            .padding(.horizontal)
            
        }
    }
}

struct newsCard {
    var headline: String
    var title: String
    var image: String
    var address: String
}

func getNews() -> [newsCard] {
    
    var news = [newsCard]()
//MARK: here's the synch loading it doesn't like
        let url = URL (string: "https://www.f1academy.com/Latest")!
        let html = try? String(contentsOf: url, encoding: .utf8)
        let document = try! SwiftSoup.parse(html ?? "")

    for i in 0...19 {
        let headline = try! document.select("div.row div.article-listing-card--item:eq(\(i)) .font-text-body")
        let title = try! document.select("div.row div.article-listing-card--item:eq(\(i)) .font-tag")
        let address = try! document.select("div.row div.article-listing-card--item:eq(\(i)) a")
        let addressNew = ("https://www.f1academy.com" + "\(try! address.attr("href"))")
        let image = try! document.select("div.row div.article-listing-card--item:eq(\(i)) a div.f1-cc--image img.f1-cc--photo")
        let imageNew = "\(try! image.attr("data-src"))"
        
        news.append(newsCard(headline: "\(try! headline.text())", title: "\(try! title.text())", image: imageNew, address: addressNew))
    }
    
    return news
}

struct NewsPage: View {
    @State var news: [newsCard] = getNews()
    
    var body: some View {
        NavigationView {
            ZStack{
//                Color(.backdrop)
//                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    //Top bar with the race countdown
                    HStack{
                        VStack{
                            Text("nextrace")
                                .font(.custom("Formula1-Display-Regular", size: 30))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("SEP 19-20")
                                .font(.custom("Formula1-Display-Regular", size: 12))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        //TODO: proper countdown
                        Text(Date().addingTimeInterval(600), style: .relative)
                            .font(.custom("Formula1-Display-Regular", size: 24))
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
//                    .background(.accent)
                    
                    //Scrollable part of news page
                    ScrollView {
                        VStack{
                            headliner (headline: news[0].headline, title: news[0].title, img: news[0].image, address: news[0].address)
                            ForEach(1...19, id: \.self) {i in
                                headline2 (headline: news[i].headline, title: news[i].title , img: news[i].image, address: news[i].address)
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    NewsPage()
}

