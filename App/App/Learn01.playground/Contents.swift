//: Playground - noun: a place where people can play

import UIKit


// 斐波那契数序列生成器:
class FibonacciGenerator: GeneratorType {
    var last = (0,1)
    var endAt: Int
    var lastIteration = 0
    typealias Element = Int
    init(end: Int) {
        endAt = end
    }
    
    func next() -> Element? {
        guard lastIteration < endAt else {
            return nil
        }
        lastIteration++
        let next = last.0
        last = (last.1, last.0 + last.1)
        return next
    }
    
}

var fg = FibonacciGenerator(end: 10)
while let fib = fg.next() {
    print(fib)
}


// 递减生成器
class CountdownGenerator: GeneratorType {
    typealias Element = Int
    var element: Element
    
    init<T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return element < 0 ? nil : element--
    }
}

let xs = ["A","B","C"]
let generator = CountdownGenerator(array: xs)
while let i = generator.next() {
    print("Element \(i) of the array is \(xs[i])")
    
}



/**
*  根据生成器实现一个SequenceType
*/
class FibonacciSequence : SequenceType {
    var endAt: Int
    typealias Generator = FibonacciGenerator
    init(end: Int) {
        endAt = end
    }
    
    func generate() -> Generator {
        return FibonacciGenerator(end: endAt)
    }
}

let arr = Array(FibonacciSequence(end: 10))
for f in FibonacciSequence(end: 10) {
    print(f)
}




class FileLinesGenerator: GeneratorType {
    typealias Element = String
    var lines: [String]
    
    init(filename: String) {
        do {
            let contents = try String(contentsOfFile: filename, encoding: NSUTF8StringEncoding)
            let newLine = NSCharacterSet.newlineCharacterSet()
            lines = contents.componentsSeparatedByCharactersInSet(newLine)
        } catch {
            lines = []
        }
    }
    
    func next() -> Element? {
        if let nextLine = lines.first {
            lines.removeAtIndex(0)
            return nextLine
        } else {
            return nil
        }
    }
}

func find<G: GeneratorType>(var generator: G, predicate: G.Element -> Bool) -> G.Element? {
    while let x = generator.next() {
        if predicate(x) {
            return x
        }
        
    }
    return nil
}



class LimitGenerator<G: GeneratorType> : GeneratorType {
    typealias Element = G.Element
    var limit = 0
    var generator: G
    
    init(limit: Int, generator: G) {
        self.limit = limit
        self.generator = generator
    }
    
    func next() -> Element? {
        if limit >= 0 {
            limit--
            return generator.next()
        } else {
            return nil
        }
    }
}
















