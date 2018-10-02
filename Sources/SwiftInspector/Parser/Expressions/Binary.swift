//
//  Binary.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/27/18.
//

import Foundation

/*
 Binary Expressions
 
 binary-expression → binary-operator prefix-expression
 binary-expression → assignment-operator try-operator(opt) prefix-expression
 binary-expression → conditional-operator try-operator(opt) prefix-expression
 binary-expression → type-casting-operator
 binary-expressions → binary-expression binary-expressions(opt)
 
 GRAMMAR OF AN ASSIGNMENT OPERATOR
 
 assignment-operator → =
 
 GRAMMAR OF A CONDITIONAL OPERATOR
 
 conditional-operator → ? expression :
 
 GRAMMAR OF A TYPE-CASTING OPERATOR
 
 type-casting-operator → is type
 type-casting-operator → as type
 type-casting-operator → as ? type
 type-casting-operator → as ! type
 */

/*
 Operator Precedence (Highest to Lowest) [Not complete]
 https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations#2903070
 !      Logical NOT
 *      Multiply                    Left Associative        MultiplicationPrecedence
 /      Divide                      Left Associative        MultiplicationPrecedence
 %      Remainder                   Left Associative        MultiplicationPrecedence
 +      Addition                    Left Associative        AdditionPrecedence
 -      Subtract                    Left Associative        AdditionPrecedence
 ..<    Half-open Range             None                    RangeFormationPrecedence
 ...    Closed Range                None                    RangeFormationPrecedence
 is     Type check                  Left Associative        CastingPrecedence
 as     Type cast                   Left Associative        CastingPrecedence
 as?    Type cast                   Left Associative        CastingPrecedence
 as!    Type cast                   Left Associative        CastingPrecedence
 ??     Nil coalescing              Right Associative       NilCoalescingPrecedence
 <      Less than                   None                    ComparisonPrecedence
 <=     Less than or equal          None                    ComparisonPrecedence
 >      Greater than                None                    ComparisonPrecedence
 >=     Greater than or equal       None                    ComparisonPrecedence
 ==     Equal                       None                    ComparisonPrecedence
 !=     Not equal                   None                    ComparisonPrecedence
 ===    Identical                   None                    ComparisonPrecedence
 !==    Not identical               None                    ComparisonPrecedence
 ~=     Pattern match               None                    ComparisonPrecedence
 &&     Logical AND                 Left Associative        LogicalConjunctionPrecedence
 ||     Logical OR                  Left Associative        LogicalDisjunctionPrecedence
 ?:     Ternary conditional         Right Associative       Ternary Precendence
 =      Assign                      Right Associative       Assignment Precendence
 *=     Mutliply and assign         Right Associative       Assignment Precendence
 /=     Divide and assign           Right Associative       Assignment Precendence
 %=     Remainder and assign        Right Associative       Assignment Precendence
 +=     Add and assign              Right Associative       Assignment Precendence
 -=     Subtract and assign         Right Associative       Assignment Precendence
 
 
 addition -> prefix (( "+" | "-" ) prefix)*
 prefix -> ( "!" ) prefix
 | primary
 primary -> Int | String | Bool | nil
 */

public enum BinaryExpression {
    indirect case prefix(operator: Token, lhs: PrefixExpression, rhs: PrefixExpression)
    indirect case binary(operator: Token, lhs: BinaryExpression, rhs: BinaryExpression)
    indirect case assignment(try: Bool?, rhs: BinaryExpression)
    case conditional
    indirect case typeCasting(operator: Token, lhs: BinaryExpression, rhs: BinaryExpression)
}

extension BinaryExpression: AutoEquatable {}

extension BinaryExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .prefix(let `operator`, let lhs, let rhs):
            if let lhs = lhs {
                return "(\(`operator`.type) \(lhs) \(rhs))"
            } else {
                return "(\(`operator`.type) \(rhs))"
            }
        default: return "implement"
        }
    }
}
