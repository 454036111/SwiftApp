# IOS 测试

### 1. 测试驱动开发 TDD: Test Driven Development 

	我们一般能想到的是先编写业务代码，然后为其编写测试代码，用来验证产品方法是不是按照设计工作。
	而TDD的思想正好与之相反，先测试 后编码。
	
	使用XCTest的测试框架来执行TDD. 
	
	但是在使用XCTest测试的另一个问题是难以进行mock或者stub
	
	

### 2. 行为驱动开发 BDD:Behavior Driven Development

	BDD提倡的是通过将测试语句转化为类似的自然语言的描述，开发人员可以使用更符合大众语言的习惯来书写测试。 一个典型的BDD的测试用例包括三段式上下文，`Given..When.. Then`. 
	
	swift 上推荐使用Quick 




