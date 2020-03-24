import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderServiceProtocol: class {
    func loadImage(from url: URL?) -> AnyPublisher<UIImage?, Never>
}

final class ImageLoaderService: ImageLoaderServiceProtocol {
    private let cache: ImageCacheType = ImageCache()

    func loadImage(from url: URL?) -> AnyPublisher<UIImage?, Never> {
        guard let url = url else { return .just(nil) }
        
        if let image = cache.image(for: url) {
            return .just(image)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .print("Image loading \(url):")
            .eraseToAnyPublisher()
    }
}
