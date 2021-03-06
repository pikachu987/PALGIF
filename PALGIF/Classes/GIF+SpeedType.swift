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

import Foundation

extension GIF {
    public enum SpeedType {
        case moreSlow, slow, normal, fast, moreFast
        case custom(Double)

        public var value: Double {
            switch self {
            case .moreSlow:
                return 2.3
            case .slow:
                return 1.8
            case .normal:
                return 1.2
            case .fast:
                return 0.8
            case .moreFast:
                return 0.3
            case let .custom(speed):
                return speed
            }
        }
        
        public static func ==(lhs: SpeedType, rhs: SpeedType) -> Bool {
            switch (lhs, rhs) {
            case (.moreSlow, .moreSlow):
                return true
            case (.slow, .slow):
                return true
            case (.normal, .normal):
                return true
            case (.fast, .fast):
                return true
            case (.moreFast, .moreFast):
                return true
            case (.custom, .custom):
                return true
            default:
                return false
            }
        }
        
        public static func ===(lhs: SpeedType, rhs: SpeedType) -> Bool {
            switch (lhs, rhs) {
            case (.moreSlow, .moreSlow):
                return true
            case (.slow, .slow):
                return true
            case (.normal, .normal):
                return true
            case (.fast, .fast):
                return true
            case (.moreFast, .moreFast):
                return true
            case let (.custom(value1), .custom(value2)):
                return value1 == value2
            default:
                return false
            }
        }
    }
}
