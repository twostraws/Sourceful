import XCTest
@testable import Sourceful

final class SourcefulTests: XCTestCase {
    func testSyntaxTextViewDelegateDidChangeTextShouldNotBeCalledWhenSetProgrammatically() {
        let textView = SyntaxTextView()
        textView.delegate = TestDelegate(didChangeText: {
            XCTFail("Delegate's didChangeText should not be called when text is set programmatically.")
        })
        textView.text = "My new text"
    }

    static var allTests = [
        ("testSyntaxTextViewDelegateDidChangeTextShouldNotBeCalledWhenSetProgrammatically", testSyntaxTextViewDelegateDidChangeTextShouldNotBeCalledWhenSetProgrammatically),
    ]
}

class TestDelegate: SyntaxTextViewDelegate {
    var didChangeText: () -> Void
    
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        didChangeText()
    }
    
    func lexerForSource(_ source: String) -> Lexer {
        SwiftLexer()
    }
    
    init(didChangeText: @escaping () -> Void) {
        self.didChangeText = didChangeText
    }
}
