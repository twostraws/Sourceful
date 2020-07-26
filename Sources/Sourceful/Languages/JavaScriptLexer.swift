//
//  JavaScriptLexer.swift
//  
//  Based on SwiftLexer.swift by Louis D'hauwe.
//  Based on JavaScriptLexer.swift by Zachary Gibson
//  Created by Nikita Skrypchenko on 7/26/20.
//

import Foundation

public class JavaScriptLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "abstract arguments await boolean break byte case catch char class    const continue debugger default delete do double else enum eval export extends false final finally float for function goto if implements import in instanceof int interface let long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with yield".components(separatedBy: " ")
        
        let builtInObjectsIdentifiers = "Infinity NaN undefined null globalThis Object Function Boolean Symbol Error AggregateError  EvalError InternalError  RangeError ReferenceError SyntaxError TypeError URIError Number BigInt Math Date String RegExp Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Map Set WeakMap WeakSet ArrayBuffer SharedArrayBuffer  Atomics  DataView JSON Promise Generator GeneratorFunction AsyncFunction Iterator  AsyncIterator  Reflect Proxy Intl Intl.Collator Intl.DateTimeFormat Intl.ListFormat Intl.NumberFormat Intl.PluralRules Intl.RelativeTimeFormat Intl.Locale arguments".components(separatedBy: " ")
        
        let lamdaFunctions = "__ add addIndex adjust all allPass always and andThen any anyPass ap aperture append apply applySpec applyTo ascend assoc assocPath binary bind both call chain clamp clone comparator complement compose composeK composeP composeWith concat cond construct constructN contains converge countBy curry curryN dec defaultTo descend difference differenceWith dissoc dissocPath divide drop dropLast dropLastWhile dropRepeats dropRepeatsWith dropWhile either empty endsWith eqBy eqProps equals evolve F filter find findIndex findLast findLastIndex flatten flip forEach forEachObjIndexed fromPairs groupBy groupWith gt gte has hasIn hasPath head identical identity ifElse inc includes indexBy indexOf init innerJoin insert insertAll intersection intersperse into invert invertObj invoker is isEmpty isNil join juxt keys keysIn last lastIndexOf length lens lensIndex lensPath lensProp lift liftN lt lte map mapAccum mapAccumRight mapObjIndexed match mathMod max maxBy mean median memoizeWith merge mergeAll mergeDeepLeft mergeDeepRight mergeDeepWith mergeDeepWithKey mergeLeft mergeRight mergeWith mergeWithKey min minBy modulo move multiply nAry negate none not nth nthArg o objOf of omit once or otherwise over pair partial partialRight partition path pathEq pathOr paths pathSatisfies pick pickAll pickBy pipe pipeK pipeP pipeWith pluck prepend product project prop propEq propIs propOr props propSatisfies range reduce reduceBy reduced reduceRight reduceWhile reject remove repeat replace reverse scan sequence set slice sort sortBy sortWith split splitAt splitEvery splitWhen startsWith subtract sum symmetricDifference symmetricDifferenceWith T tail take takeLast takeLastWhile takeWhile tap test thunkify times toLower toPairs toPairsIn toString toUpper transduce transpose traverse trim tryCatch type unapply unary uncurryN unfold union unionWith uniq uniqBy uniqWith unless unnest until update useWith values valuesIn view when where whereEq without xor xprod zip zipObj zipWith".components(separatedBy: " ")
               
               generators.append(keywordGenerator(lamdaFunctions, tokenType: .identifier))
        
        generators.append(keywordGenerator(builtInObjectsIdentifiers, tokenType: .identifier))
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        // Line comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))
        
        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Multi-line string literal
        generators.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
