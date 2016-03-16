//: Playground - noun: a place where people can play

import UIKit

/**
*  Functors, Applicative Functors, and Mondads
*/

/* :Functors
 : are sometimes described as "Containers" stroing values of some type
 
 : 如何作用于自己的类型的都是Functor, 如map
 : functor 是一种实现了 map 的数据类型；
 : 通过 map 对封装的值使用了函数.
 : Functor 为封装的值应用一个函数：
 
*/
typealias Position = CGPoint

struct  Region<T> {
    let value: Position -> T
}

func map<T, U>(region: Region<T>, transform: T->U) -> Region<U> {
    return Region{
        pos in transform(region.value(pos))
    }
}


/*
: applicative 知道如何将一个封装在上下文之中的函数作用于封装在同样上下文之中的值.
: applicative 是一个种实现了 apply 的数据类型；
: Applicatives 为封装的值应用一个封装的函数：
*/

extension Optional {
    func apply<U>(f: (Wrapped -> U)?) ->U? {
        switch f {
            
        case .Some(let someF): return self.map(someF)
            
        case .None: return .None
            
        }
        
    }
}

extension Array {
    
    func apply<U>(fs: [Element -> U]) -> [U] {
        var result = [U]()
        for f in fs {
            for element in self.map(f) {
                result.append(element)
            }
        }
        
        return result
    }
}

Optional.Some(2).apply(Optional.Some({$0 + 3}))

let a = [1,2,3].apply([{$0 + 3}, {$0 * 2}])
print(a)


infix operator <*> {associativity  left}
func <*><T, U>(f: (T->U)?, a: T?) -> U? {
    return a.apply(f)
}

func <*><T,U>(f: [T->U], a:[T])-> [U] {
    return a.apply(f)
}

Optional.Some({$0 + 3}) <*> Optional.Some(2)

[{$0 + 3}, {$0 * 2}] <*> [1,2,3]  // [4, 5, 6, 2, 4, 6]

/*
: Monads 为封装的值，应用一个返回封装值的函数
: Monads 有个函数 flatMap
*/

infix operator >>- {associativity left}
func >>- <T, U>(a: T? , f: T -> U?) -> U? {
    
    return a.flatMap(f)
}

func half(a: Int) -> Int? {
    return a%2 == 0 ? a/2 : .None
}

Optional(3) >>- half
Optional(4) >>- half

Optional(4) >>- half >>- half
Optional(4)
    >>- half
    >>- half
    >>- half









