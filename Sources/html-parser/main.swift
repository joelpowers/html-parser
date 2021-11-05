import Foundation

print("Hello, world");
/*
* this struct will wrap all the networking functionality
*/
struct HTTPFetcher {
    
    enum HTTPRetrieveError: Error {
        case invalidURL
        case missingData
    }
    // todo find a way better name for this
    static func wrapURLSession(address: String) async throws -> String {
        guard let url = URL(string: address) else {
            throw HTTPRetrieveError.invalidURL
        }
        // Use the async variant of URLSession to fetch data
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }

}

/*
*  Must wrap call to async function in a Task.
*  TODO - find a better way to do this.
*/
let handle = Task {
    do {  
        let rawHtml = try await HTTPFetcher.wrapURLSession(address: "https://www.example.com")
        print(rawHtml)
    } catch {
        print("Request failed with error: \(error)")
    }
}

// CLI will quit before the fetch returns.  Sleep to allow async functions to return
sleep(10)