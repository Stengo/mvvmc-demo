import Foundation

class DetailEndpoint: Endpoint {
    private(set) var itemIndex: Int?
    
    init(itemIndex: Int) {
        self.itemIndex = itemIndex
    }
}
