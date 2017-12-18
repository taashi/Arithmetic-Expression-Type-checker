# Arithmetic-Expression-Type-checker
Please clone both the files for the project to work at your end.
The extras file is required for the project file to work.
A type is one of
Int
Op0
Op1
Error
The type of an arithmetic expression is defined as follows:
The type of a Literal is Int
If a Variable is used outside of any region for the variable, then the type of that use of the variable is Error; otherwise the type of that use of the variable is the type of the expression on the right hand side of the innermost definition of the variable whose region includes the use.
The type of (op "+") is Op0.
The type of (op "*") is Op0.
The type of (op "-") is Op1.
The type of (op "/") is Op1.
If the operator of a call has type Op0, and all of its operands have type Int, then the type of the call is Int.
If the operator of a call has type Op1, and all of its operands have type Int, and there is at least one operand, then the type of the call is Int.
If neither of the two rules above specifies the type of a call, then its type is Error.
If the right-hand side of a block's definition has type Error, then the type of that block is Error; otherwise the type of the block is the type of its body.
An arithmetic expression is well-typed if and only if its type is not Error.
