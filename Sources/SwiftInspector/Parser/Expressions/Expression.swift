//
//  Expression.swift
//  SwiftInspector
//
//  Created by Pasan Premaratne on 9/26/18.
//

import Foundation

/*
 Grammar of an Expression
 
 expression -> try-operator(opt) prefix-expression binary-expressions(opt)
 expression-list -> expression | expression , expression-list
*/

protocol Expression: Statement {
    
}

/*
 Prefix Expressions
 
 prefix-expression → prefix-operator(opt) postfix-expression
 prefix-expression → in-out-expression
 in-out-expression → & identifier
 */

/*
 Binary Expressions
 
 binary-expression → binary-operator prefix-expression
 binary-expression → assignment-operator try-operator opt prefix-expression
 binary-expression → conditional-operator try-operator opt prefix-expression
 binary-expression → type-casting-operator
 binary-expressions → binary-expression binary-expressions opt
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
