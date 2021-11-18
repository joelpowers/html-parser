import Foundation
import SwiftSoup

enum HTTPRetrieveError: Error {
    case invalidURL
    case missingData
}

func parseWrap(rawHtml: String) -> String {
    do {
        let doc: Document = try SwiftSoup.parse(rawHtml)
        let articles: Elements = try doc.getElementsByClass("gamePod-game-teams")
        print("articles size: \(articles.size())")
        for article: Element in articles {
            print("####################################")
            let awayTeam = article.child(0)
            let homeTeam = article.child(1)
            try print("away: \(awayTeam.getElementsByClass("gamePod-game-team-name").text())")
            try print("home: \(homeTeam.getElementsByClass("gamePod-game-team-name").text())")

        }
    } catch Exception.Error(_, let message) {
            print(message)
    } catch {
            print("error")
        }
    return "";
}

// todo find a way better name for this
func wrapURLSession(address: String) async throws -> String {
    guard let url = URL(string: address) else {
        throw HTTPRetrieveError.invalidURL
    }
    // Use the async variant of URLSession to fetch data
    let (data, _) = try await URLSession.shared.data(from: url)
    return String(decoding: data, as: UTF8.self)
}

var rawHtml: String = "";
let handle = Task {
    do {  
        let html = try await wrapURLSession(address: "https://www.ncaa.com/scoreboard/football/fbs/2021/01/all-conf")
        rawHtml = html;
    } catch {
        print("Request failed with error: \(error)")
    }
}
// CLI will quit before the fetch returns.  Sleep to allow async functions to return
// Must be a better way!!!
sleep(10) 

print(parseWrap(rawHtml: rawHtml))
