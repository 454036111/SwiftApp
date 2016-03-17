**谈谈设计 `Result` **

**在OC时代**, 处理异常：

1. 直接判断

		NSError *err = nil;
		SomeT result = [XX doSomethine: &err];
		if (err) {
			// handle err
		} else {
			// handle success
		}
2. 通过block

		[xx doSomethingWithSuccess:^(id res){
			// handle success
		} failure: ^(NSError *err){
			// handle err
		}];
		
3. 由于第2种的对结果分散处理，然后有：

		[xx doSomethingWithSCompletionHandler:^(id res, NSError *err){
			
			if (!error){
				if (result) {
					// handle res
				}
			} else {
				// handle err
			}
			
		}];
		
	第3种模式`CompletionHandler`来统一结果处理，这种设计在系统上比比皆是。
	
	但是我们学习swift之后，我们是不是有另一种处理方式?
	
	
**swift时代：**

匹配模式：

	enum Result {
		case Failure(MaybeErrorType)
    	case Success(Box<T>)
	}
	
	
	xx.doSomethingWithCompletionHandler {
		result in 
		switch result {
			case let .Failure(e):
				// do 
			case let .Value(ret):
				// do 
		}
		
	}
	
	
这种设计看起来像2又似3. 在本项目你看到很多地方都有类似的处理方式,好处：

	1. 安全，switch， 不会遗失分支
	2. 统一处理结果，保证逻辑的统一性