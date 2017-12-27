# Expressions
Arithmetic and logical expressions elegantly modeled and visualized using protocol-oriented binary trees with value semantics.

## Features
- [x] Model arithmetic and logical expressions using binary trees.
- [x] Write expressions in code in the same manner as they would be written for evaluation, i.e. making full use of literals and binary operators.
- [x] Visualize expressions by rendering image representations, which can be easily seen using the Xcode Playground QuickLook feature.
- [x] Animate the evaluation of expressions using `UIView`s, and observe these animations using the Xcode Playground Live View feature.
- [ ] Support unary operators in expressions.
- [x] Demonstrate the power of protocol-oriented programming by creating other simple tree structures, such as binary search trees, which gain QuickLook visualization for free.

## Contents
The principal focus of this project is to demonstrate the structure and evaluation of arithmetic and logical expressions in an elegant, expressive way. Thanks to Swift's powerful `ExpressibleBy*Literal` protocols and operator overloading, we can write code like this:

```swift
let expression: ArithmeticExpression<Int> = 2*(1+3)-8/4
```

and in doing so create the full tree representing this expression, which in turn can be visualized in an Xcode Playground via QuickLook:

![ArithmeticExpression visualized](Expressions/Images/ArithmeticExpression.png)

And, to step it up another notch, we can animate the evaluation of this expression by calling `animateEvaluation(of:)` in a Playground page. We can observe this animation in the Playground's Live View:

![ArithmeticExpression evaluation animated]()

In addition to arithmetic expressions, logical expressions can be similarly created, viewed, and animated.

Furthermore, as a simple demonstration of the power of protocol-oriented programming, I've implemented a couple of other tree structures, including a traditional binary search tree and a red-black tree, which can also be visualized with QuickLook.

## Getting Started
While a brief outline of the project's contents is provided in the section above, this is a Playground-based project and ultimately better demonstrated than explained:

1. Clone the project.
2. Open **Expression.xcworkspace**.
3. Build the project.
4. Within the Expression Playground, navigate to the ArithmeticExpression page to begin.
5. See the magic through Xcode Playground's QuickLook and Live View features. Each Playground Page demonstrates a type of expression or other tree-based structure.

## License
Expressions is released under the MIT license. See [LICENSE]() for details.

If you find this project to be a useful tool in learning or teaching expressions or binary trees, please reach out to me [on Twitter](https://twitter.com/michaelpangbu)--I'd love to hear from you.

