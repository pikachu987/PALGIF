//Copyright (c) 2021 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit
import MobileCoreServices

extension GIF {
    open class func make(_ datas: [Data], speed: SpeedType, loop: Int = 0, url: URL? = nil) throws -> GIFData {
        return try self.make(datas.compactMap({ UIImage(data: $0) }), speed: speed, loop: loop, url: url)
    }
    
    open class func make(_ images: [UIImage], speed: SpeedType, loop: Int = 0, url: URL? = nil) throws -> GIFData {
        let fileProperties = [
            kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loop]
        ]
        let frameProperties = [
            kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: speed.value]
        ]
        var url = url
        if url == nil {
            let documentsDirectory = NSTemporaryDirectory()
            url = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("animated.gif")
        }
        guard let saveURL = url else {
            throw NSError(domain: "Error URL Not Found", code: 404, userInfo: nil) as Error
        }
        guard let destination = CGImageDestinationCreateWithURL(saveURL as CFURL, kUTTypeGIF, images.count, nil) else {
            throw NSError(domain: "Error Create URL", code: 503, userInfo: nil) as Error
        }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        images.forEach { (image) in
            if let cgImage = image.cgImage {
                CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
            }
        }
        if CGImageDestinationFinalize(destination) {
            let data = try Data(contentsOf: saveURL)
            return GIFData(data: data, url: saveURL)
        } else {
            throw NSError(domain: "Error", code: 501, userInfo: nil) as Error
        }
    }
}
