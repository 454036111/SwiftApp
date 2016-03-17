//: Playground - noun: a place where people can play

import UIKit

import RxSwift


_ = Observable.of(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
    .reduce(0, accumulator: +)
    .subscribe {
        print($0)
}




