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

extension GIF {
    public var gifImage: UIImage? {
        let count = CGImageSourceGetCount(self.source)
        var images = [CGImage]()
        var delays = [Int]()
        (0..<count).forEach { (index) in
            if let image = CGImageSourceCreateImageAtIndex(self.source, index, nil) {
                images.append(image)
            }
            let delaySeconds = self.delay(index, source: self.source)
            delays.append(Int(delaySeconds * 1000))
        }
        let duration = delays.reduce(0, +)
        let value = self.delayValue(delays)
        var frames = [UIImage]()
        (0..<count).forEach { (index) in
            let frame = UIImage(cgImage: images[index])
            (0..<(Int(delays[index] / value))).forEach({ _ in frames.append(frame) })
        }
        self.isGIF = !frames.isEmpty
        return UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
    }
    
    public var frameImages: [UIImage] {
        let count = CGImageSourceGetCount(self.source)
        var images = [CGImage]()
        var delays = [Int]()
        (0..<count).forEach({ (index) in
            if let image = CGImageSourceCreateImageAtIndex(self.source, index, nil) {
                images.append(image)
            }
            let delaySeconds = self.delay(index, source: self.source)
            delays.append(Int(delaySeconds * 1000))
        })
        let value = self.delayValue(delays)
        var frames = [UIImage]()
        (0..<count).forEach { (index) in
            if let data = UIImage(cgImage: images[index]).pngData(), let frame = UIImage(data: data) {
                (0..<(Int(delays[index] / value))).forEach({ _ in frames.append(frame) })
            }
        }
        self.isGIF = !frames.isEmpty
        return frames
    }
}
