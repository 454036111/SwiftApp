## [RxSwift](https://github.com/ReactiveX/RxSwift)



### 官方文档结构 

1. Introduction:
2. Subjects
3. Transforming Observables
4. Filtering Observables
5. Combining Observables
6. Error Handing Operators
7. Observable Utility Operators
8. Conditional and Boolean Operators
9. Mathematical and Aggregate Operators
10. Connectable Observable Operatiors


============

`Observable`

> Observable<Element> 是观察者模式中被观察的对象，相当于一个事件序列(GeneratorType)， 会向订阅者发送新产生的事件信息。
> 
> 事件信息分为： 

	.Next(value): 表示新的事件数据
	.Completed: 表示事件序列完结
	.Error: 异常导致的事件序列完结
	

`Subjects`

> A Subject is a sort of bridge or proxy that is available in some implementations of ReactiveX that acts both as an observer and as an Observable. 

> 
> Subject可以看做是一种代理和桥梁。它既是订阅者又是订阅源，这意味着它既可以订阅其他Observables，同时又可以对他的订阅者发送事件


	
	
###1. How to Create Observables ?

1. `empty`: 

		empty creates an empty sequence. 
		The only message it sends is the .Completed message.
		
		let emptySequence = Observable<Int>.empty()

		
		
2. `never`:

		never creates a sequence that never sends any element or completes.
		
		let neverSequence = Observable<Int>.never()

3. `just` (一个元素)

		just represents sequence that contains one element. 
		It sends two messages to subscribers. 
		The first message is the value of single element and the second 
		message is .Completed.
		
		let singleElementSequence = Observable.just(32)
		
4. `sequenceOf` (一系列元素)

		sequenceOf creates a sequence of a fixed number of elements.

		Observable.of
		
5. `from` (将swift的序列(SequenceType) 转换为事件序列)

		from creates a sequence from SequenceType
		
		let sequenceFromArray = [1, 2, 3, 4, 5].toObservable()
		
6. `create` (通过闭包创建序列)

		create creates sequence using Swift closure. 
		This examples creates custom version of just operator.
		
		let myJust = { (singleElement: Int) -> Observable<Int> in
        	return Observable.create { observer in
            observer.on(.Next(singleElement))
            observer.on(.Completed)
            
            return NopDisposable.instance
        	}
    	}
    
    	let subscription = myJust(5)
	        .subscribe { event in
	            print(event)
	    }

		
		
		
7. `generate`


		generate creates sequence that generates its values and determines 
		when to terminate based on its previous values.
		
		let generated = Observable.generate(
            initialState: 0,
        	condition: { $0 < 3 },
        	iterate: { $0 + 1 }
    	)

    	let subscription = generated
           .subscribe { event in
            print(event)
        }
8. `failWith`

		create an Observable that emits no items and terminates with an error
		
		let error = NSError(domain: "Test", code: -1, userInfo: nil)
    	let erroredSequence = Observable<Int>.error(error)

9. `deferred` (加载延迟， 订阅者的内容相同而完全独立)

		do not create the Observable until the observer subscribes, 
		and create a fresh Observable for each observer
		
		

### 2. how to create Subjects

1. `PublishSubject`（发送订阅者从订阅之后的事件序列）

		PublishSubject emits(发出) to an observer only those items that
		are emitted by the source Observable(s) subsequent to the
		time of the subscription.
		
		example("PublishSubject") {
		    let disposeBag = DisposeBag()
		
		    let subject = PublishSubject<String>()
		    writeSequenceToConsole("1", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("a"))
		    subject.on(.Next("b"))
		    writeSequenceToConsole("2", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("c"))
		    subject.on(.Next("d"))
		}
		1 - a
		1 -  b
		1 - c
		2 - c
		1 - d
		2 - d
		
		
		

2. `ReplaySubject` (在新订阅对象订阅的时候会补发所有已经发送过的数据列， buffize: 是缓冲区的大小， 为1时，那么新订阅者出现的时候就补发上一个事件，如果是2， 就补发2个 ，...)

		ReplaySubject emits to any observer all of the items that
		were emitted by the source Observable(s), regardless of 
		when the observer subscribes.
		
		example("ReplaySubject") {
		    let disposeBag = DisposeBag()
		    let subject = ReplaySubject<String>.create(bufferSize: 1)
		
		    writeSequenceToConsole("1", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("a"))
		    subject.on(.Next("b"))
		    writeSequenceToConsole("2", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("c"))
		    subject.on(.Next("d"))
		}
		print:
		1 - a
		1 - b
		2 - b // 补发1个
		1 - c
		2 - c
		1 - d
		2 - d 
		

		

3. `BehaviorSubject` (在新的订阅对象订阅的时候回发送最近发送的事件，如果没有，则发送一个默认值)

		When an observer subscribes to a BehaviorSubject, it begins 
		by emitting the item most recently emitted by the source 
		Observable (or a seed/default value if none has yet been emitted)
		and then continues to emit any other items emitted later 
		by the source Observable(s).
		
		example("BehaviorSubject") {
		    let disposeBag = DisposeBag()
		
		    let subject = BehaviorSubject(value: "z")
		    writeSequenceToConsole("1", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("a"))
		    subject.on(.Next("b"))
		    writeSequenceToConsole("2", sequence: subject).addDisposableTo(disposeBag)
		    subject.on(.Next("c"))
		    subject.on(.Next("d"))
		    subject.on(.Completed)
		}
		print:
		1 - z
		1 - a
		1 - b
		2 - b
		1 - c
		2 - c
		1 - d
		2 - d
		1 - com
		2 - com
		 

4. `Variable` (是基于BehaviorSubject的一层封装， 它的优势： 不会被显示的终结，即：不会受到.Complete或者.Error这类终结事件，它会主动在析构的时候发送.Complete)
		
		Variable wraps BehaviorSubject. Advantage of using variable over
		BehaviorSubject is that variable can never explicitly complete
		or error out, and BehaviorSubject can in case Error or Completed 
		message is send to it. Variable will also automatically complete 
		in case it's being deallocated.
		
		example("Variable") {
		    let disposeBag = DisposeBag()
		    let variable = Variable("z")
		    writeSequenceToConsole("1", sequence: variable.asObservable()).addDisposableTo(disposeBag)
		    variable.value = "a"
		    variable.value = "b"
		    writeSequenceToConsole("2", sequence: variable.asObservable()).addDisposableTo(disposeBag)
		    variable.value = "c"
		    variable.value = "d"
		}
		
		
### 3. Transforming Observables

1. `map/select`

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/map.png)
	
		example("map") {
		    let originalSequence = Observable.of(1, 2, 3)
		
		    _ = originalSequence
		        .map { number in
		            number * 2
		        }
		        .subscribe { print($0) }
		}



2. `flatMap`

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/flatmap.png)


		transform the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable.
	
		
		example("flatMap") {
		    let sequenceInt = Observable.of(1, 2, 3)
		    let sequenceString = Observable.of("A", "B","--")
		
		    _ = sequenceInt
		        .flatMap { int in
		            sequenceString
		        }
		        .subscribe {
		            print($0)
		        }
		}
		
		// 
		Next(A)
		Next(B)
		Next(--)
		Next(A)
		Next(B)
		Next(--)
		Next(A)
		Next(B)
		Next(--)
		Completed
		
		



3. `scan` 跟 swift上的reduce像

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/scan.png)
	
		example("scan") {
		    let sequenceToSum = Observable.of(0, 1, 2, 3, 4, 5)
		
		    sequenceToSum
		        .scan(0) { acum, elem in
		            acum + elem
		        }
		        .subscribe {
		            print($0)
		        }
		}
		// 
		Next(0)
		Next(1)
		Next(3)
		Next(6)
		Next(10)
		Next(15)
		Completed


### 4. Filtering Obsservables

1. `filter` 类似于swift

   ![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/filter.png)
   
		example("filter") {
		    let subscription = Observable.of(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
		        .filter {
		            $0 % 2 == 0
		        }
		        .subscribe {
		            print($0)
		        }
		}
		
		// 
		Next(0)
		Next(2)
		Next(4)
		Next(6)
		Next(8)
		Completed
  
2. `distinctUntilChanged` 废弃掉重复事件

	Suppress duplicate items emitted by an Observable
	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/distinct.png)
	
		example("distinctUntilChanged") {
		    let subscription = Observable.of(1, 2, 3, 1, 1, 4)
		        .distinctUntilChanged()
		        .subscribe {
		            print($0)
		        }
		}
		
		//
		Next(1)
		Next(2)
		Next(3)
		Next(1)
		Next(4)
		Completed

	
3. `take` 类似于 Haskell 的 take 

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/take.png)
	
		example("take") {
		    let subscription = Observable.of(1, 2, 3, 4, 5, 6)
		        .take(3)
		        .subscribe {
		            print($0)
		        }
		}
		//
		Next(1)
		Next(2)
		Next(3)
		Completed


### 5. Combining Observables

1. `startWith`: 会在队列开始之前插入一个事件元素

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/startwith.png)
	
		example("startWith") { () -> () in
		    let subscription = Observable.of(1,2,3,4,5,6)
		        .startWith(0)
		        .subscribe {
		        print($0)
		    }
		}
		//
		Next(0)
		Next(1)
		Next(2)
		Next(3)
		Next(4)
		Next(5)
		Next(6)
		Completed


2. `combineLatest`: 

	>when an item is emitted by either of two Observables, combine the latest item emitted by each Observable via a specified function and emit items based on the results of this function
	
	如果存在两条事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest 会将每个队列的最新的一个元素进行合并。


	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/combinelatest.png)
	
		example("combineLatest") { () -> () in
		    let intOb1 = PublishSubject<String>()
		    let intOb2 = PublishSubject<Int>()
		    
		    _ = Observable.combineLatest(intOb1, intOb2){ "\($0) \($1)" }.subscribe{
		        print($0)
		    }
		    
		    intOb1.on(.Next("S"))
		    intOb2.on(.Next(1))
		    intOb1.on(.Next("B"))
		    intOb2.on(.Next(2))
		}
		// 
		Next(S 1)
		Next(B 1)
		Next(B 2)
	
	


3. `zip`

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/zip.png)
	
		example("zip ") {
		    let intOb1 = PublishSubject<String>()
		    let intOb2 = PublishSubject<Int>()
		    
		    _ = Observable.zip(intOb1, intOb2) {
		        "\($0) \($1)"
		        }
		        .subscribe {
		            print($0)
		    }
		    
		    intOb1.on(.Next("S"))
		    
		    intOb2.on(.Next(1))
		    
		    intOb1.on(.Next("B"))
		    
		    intOb1.on(.Next("C"))
		    
		    intOb2.on(.Next(2))
		}
		//
		--- zip  example ---
		Next(S 1)
		Next(B 2)


	
	
	
4. `merge`

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/merge.png)
	
		example("merge") {
		    let subject1 = PublishSubject<Int>()
		    let subject2 = PublishSubject<Int>()
		    
		    _ = Observable.of(subject1, subject2)
		        .merge()
		        .subscribeNext { int in
		            print(int)
		    }
		    
		    subject1.on(.Next(2))
		    subject1.on(.Next(4))
		    subject1.on(.Next(20))
		    subject2.on(.Next(1))
		    subject1.on(.Next(80))
		    subject1.on(.Next(100))
		    subject2.on(.Next(1))
		}
			
	
5. `switchLatest`

	![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/switch.png)

		example("switchLatest") {
		    let var1 = Variable(0)
		    let var2 = Variable(200)
		    // var3 is like an Observable<Observable<Int>>
		    let var3 = Variable(var1.asObservable())
		    let d = var3
		        .asObservable()
		        .switchLatest()
		        .subscribe {
		            print($0)
		    }
		    
		    var1.value = 1  // 1
		    var1.value = 2  // 2
		    var1.value = 3  // 3
		    var1.value = 4  // 4
		    
		    var3.value = var2.asObservable()  // 200
		    var1.value = 5  // no print
		    var2.value = 201 //201
		
		    var1.value = 5  // no print
		    var1.value = 6  // no print
		    var1.value = 7  // no print
		}
		
		// 
		Next(0)
		Next(1)
		Next(2)
		Next(3)
		Next(4)
		Next(200)
		Next(201)
		Completed

	
### 6. Error Handing Operators

### 7. Observable Utility Operators

### 8. Conditional and Boolean Operators

### 9. Mathematical and Aggregate Operators

### 10. Connectable Observable Operatiors


















	
	
		











