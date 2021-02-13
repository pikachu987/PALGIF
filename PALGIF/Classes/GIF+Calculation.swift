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
    func delayValue(_ array: Array<Int>) -> Int {
        if array.isEmpty { return 1 }
        var value = array[0]
        for val in array {
            value = self.pair(val, value)
        }
        return value
    }
    
    func pair(_ a: Int?, _ b: Int?) -> Int {
        if var a = a, var b = b {
            if a < b {
                let c = a
                a = b
                b = c
            }
            var rest: Int
            while true {
                rest = a % b
                if rest == 0 {
                    return b
                } else {
                    a = b
                    b = rest
                }
            }
        } else {
            if let b = b { return b }
            else if let a = a { return a }
            else { return 0 }
        }
    }
    
    func delay(_ index: Int, source: CGImageSource) -> Double {
        var delay = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        guard let cfUnsafeRawValue = CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()) else { return 0.1 }
        let gifProperties: CFDictionary = unsafeBitCast(cfUnsafeRawValue, to: CFDictionary.self)
        guard let gifUnsafeRawValue = CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()) else { return 0.1 }
        var delayObject: AnyObject = unsafeBitCast(gifUnsafeRawValue, to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            guard let gifUnsafeRawValue = CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()) else { return 0.1 }
            delayObject = unsafeBitCast(gifUnsafeRawValue, to: AnyObject.self)
        }
        delay = delayObject as? Double ?? 0.1
        if delay < 0.1 { delay = 0.1 }
        return delay
    }
}
