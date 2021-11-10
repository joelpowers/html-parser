import Foundation
import SwiftSoup

do {
   let html = "<html><head><title>First parse</title></head>"
       + "<body><p>Parsed HTML into a doc.</p></body></html>"
   let doc: Document = try SwiftSoup.parse(html)
   print(try doc.text())
} catch Exception.Error(_, let message) {
    print(message)
} catch {
    print("error")
}
