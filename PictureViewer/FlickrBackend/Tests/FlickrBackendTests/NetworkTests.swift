import XCTest
@testable import FlickrBackend

final class NetworkTests: XCTestCase {
    func testGETPhotos() async {
        let photos: PhotosResponse = try! await Network.shared.GET(method: .flickrPhotosSearch, params: [.text(text: "Tokyo")])
        XCTAssertEqual(photos.photos.photo.count, 100)
        XCTAssertEqual(photos.photos.page, 1)
    }
    
    func testGETPhotosPage2() async {
        let photos: PhotosResponse = try! await Network.shared.GET(method: .flickrPhotosSearch, params: [.text(text: "Tokyo"), .page(page: 2)])
        XCTAssertEqual(photos.photos.photo.count, 100)
        XCTAssertEqual(photos.photos.page, 2)
    }
    
    func testGETPhotosWithExtras() async {
        let photos: PhotosResponse = try! await Network.shared.GET(method: .flickrPhotosSearch, params: [.text(text: "Tokyo"), .extras(extras: [.description, .date_upload, .date_taken, .owner_name, .geo, .url_m])])
        XCTAssertEqual(photos.photos.photo.count, 100)
        XCTAssertEqual(photos.photos.page, 1)
        XCTAssertNotNil(photos.photos.photo.first?.url_m)
    }
}
