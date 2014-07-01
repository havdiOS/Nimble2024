import Foundation

func beginWith<S: Sequence, T: Equatable where S.GeneratorType.Element == T>(startingElement: T) -> MatcherFunc<S> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "begin with <\(startingElement)>"
        var actualGenerator = actualExpression.evaluate().generate()
        return actualGenerator.next() == startingElement
    }
}

func beginWith(startingElement: AnyObject) -> MatcherFunc<KICOrderedCollection> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "begin with <\(startingElement)>"
        return actualExpression.evaluate().indexOfObject(startingElement) == 0
    }
}

func beginWith(startingSubstring: String) -> MatcherFunc<String> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "begin with <\(startingSubstring)>"
        let actual = actualExpression.evaluate()
        let range = actual.rangeOfString(startingSubstring)
        return range.startIndex == actual.startIndex
    }
}