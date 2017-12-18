;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require rackunit)
(require "extras.rkt")
(provide
 lit
 literal-value
 var
 variable-name
 op
 operation-name
 call
 call-operator
 call-operands
 block
 block-var
 block-rhs
 block-body
 literal?
 variable?
 operation?
 call?
 block?
 undefined-variables
 well-typed?)
;;A type is one of
;Int
;Op0
;Op1
;Error
;;OBSERVER TEMPLATE
;;; type-fn : Type -> ??
#;
(define (type-fn t)
  (cond ((int? t) ...)
        ((op0? t) ...)
        ((op1? t) ...)
        ((error? t) ...)))

;;REPRESENTATION : A Var-ty struct can be represented as
;;(define-struct var-ty(var type))
;;(make-var-ty var type)
;; with the following fields-
;;var : Real represents real number of the literal
;;type:

;;IMPLEMENTATION:
(define-struct var-ty(var type))

;;CONSTRUCTOR TEMPLATE:
;;(make-var-ty var type)

;;OBSERVER TEMPLATE :
;;;; var-ty-fn : Var-ty -> ?
;;(define (var-ty-fn v)
;; (...
;;  (var-ty-var v)
;(var-ty-type v)))
 
;; A DvarList is represented as a list of String of defined variables.

;; OBSERVER TEMPLATE:
;; vl-fn : StringList -> ??
;;(define (vl-fn lst)
;;(cond
;; [(empty? lst) ...]
;;[else (... (first lst)
;;         (vl-fn (rest lst)))]))
;; A DvarList is represented as a
;;list of Strings

;; CONSTRUCTOR TEMPLATE AND INTERPRETATION
;; empty                  -- the empty sequence
;; (cons v vs)
;;   WHERE:
;;    v is String     -- the first string
;;                           in the sequence
;;    vs is a StringList -- the rest of the 
;;                           strings in the sequence



;; A DList is represented as a list of String of the variables.

;; OBSERVER TEMPLATE:
;; dl-fn : StringList -> ??
;;(define (dl-fn lst)
;;(cond
;; [(empty? lst) ...]
;;[else (... (first lst)
;;         (dl-fn (rest lst)))]))
;; A DList is represented as a
;;list of Strings

;; CONSTRUCTOR TEMPLATE AND INTERPRETATION
;; empty                  -- the empty sequence
;; (cons d ds)
;;   WHERE:
;;    d is String     -- the first string
;;                           in the sequence
;;    ds is a StringList -- the rest of the 
;;                           strings in the sequence

;;; An OperationName is represented as one of the following strings:
;;;     -- "+"      (indicating addition)
;;;     -- "-"      (indicating subtraction)
;;;     -- "*"      (indicating multiplication)
;;;     -- "/"      (indicating division)
;;;
;;; OBSERVER TEMPLATE:
;;; operation-name-fn : OperationName -> ??
#;
(define (operation-name-fn op)
  (cond ((string=? op "+") ...)
        ((string=? op "-") ...)
        ((string=? op "*") ...)
        ((string=? op "/") ...)))
          
;;; An ArithmeticExpression is one of
;;;     -- a Literal
;;;     -- a Variable
;;;     -- an Operation
;;;     -- a Call
;;;     -- a Block
;;;
;;; OBSERVER TEMPLATE:
;;; arithmetic-expression-fn : ArithmeticExpression -> ??
#;
(define (arithmetic-expression-fn exp)
  (cond ((literal? exp) ...)
        ((variable? exp) ...)
        ((operation? exp) ...)
        ((call? exp) ...)
        ((block? exp) ...)))
;;CONSTANTS
(define ERROR "error")
(define INT "int")
(define OP0 "op0")
(define OP1 "op1")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;REPRESENTATION : A Literal struct can be represented as
;;(make-literal value)
;; with the following fields-
;;value : Real represents real number of the literal

;;IMPLEMENTATION:
(define-struct literal (value))

;;CONSTRUCTOR TEMPLATE:
;;(make-literal real)

;;OBSERVER TEMPLATE :
;;;; literal-fn : Literal -> ?
;;(define (literal-fn l)
;; (...
;;  (literal-value l)))
 

;;; lit : Real -> Literal
;;; GIVEN: a real number
;;; RETURNS: a literal that represents that number
;;; EXAMPLE: (lit 4)->(make-literal 4)
;;;STRATEGY: Use the constructor template for Literal

(define(lit x)
  (make-literal x))

;;TESTS:
(begin-for-test
  (check-equal? (lit 5)(make-literal 5)"(make-literal 5)should be returned")
  (check-equal? (lit 16.2)(make-literal 16.2 )
                "(make-literal 16.2)should be returned"))

;;; literal-value : Literal -> Real
;;; GIVEN: a literal
;;; RETURNS: the number it represents
;;; EXAMPLE: (literal-value (lit 17.4)) => 17.4
;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(literal-value (lit 14))14 "14 should be returned")
  (check-equal?(literal-value (lit 14.5))14.5 "14.5 should be returned"))

;;REPRESENTATION : A Variable struct can be represented as
;;(make-variable name)
;; with the following fields-
;;name : String represents name of the variable ( Any string will do)

;;IMPLEMENTATION:
(define-struct variable (name))

;;CONSTRUCTOR TEMPLATE:
;;(make-variable string)

;;OBSERVER TEMPLATE :
;;;; variable-fn : Variable -> ?
;;(define (variable-fn l)
;; (...
;;  (variable-name l)))
 
;;; var : String -> Variable
;;; GIVEN: a string
;;; WHERE: the string begins with a letter and contains
;;;     nothing but letters and digits
;;; RETURNS: a variable whose name is the given string
;;; EXAMPLE:(var "fgf")->(make-variable "fgf")
;;;STRATEGY: Use the constructor template for Variable

(define(var s)
  (make-variable s))
;;TESTS:
(begin-for-test
  (check-equal? (var "x5")(make-variable "x5"))
  (check-equal? (var "tpk")(make-variable "tpk")))
          
;;; variable-name : Variable -> String
;;; GIVEN: a variable
;;; RETURNS: the name of that variable
;;; EXAMPLE: (variable-name (var "x15")) => "x15"
;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(variable-name (var "x5"))"x5" "x5 should be returned")
  (check-equal?(variable-name (var "tpk"))"tpk" "tpk should be returned"))

;;REPRESENTATION : An Operation struct can be represented as
;;(make-operation name)
;; with the following fields-
;;name : String represents name of operation( Any string will do)

;;IMPLEMENTATION:
(define-struct operation (name))

;;CONSTRUCTOR TEMPLATE:
;;(make-operation string)

;;OBSERVER TEMPLATE :
;;;; operation-fn : Operation -> ?
;;(define (operation-fn l)
;; (...
;;  (operation-string l)))
          
;;; op : OperationName -> Operation
;;; GIVEN: the name of an operation
;;; RETURNS: the operation with that name
;;; EXAMPLES: (op "*")->(make-operation "*")
;;;STRATEGY: Use the constructor template for Operation
(define(op o)
  (make-operation o))
;;TESTS:
(begin-for-test
  (check-equal? (op "+")(make-operation "+"))
  (check-equal? (op "/")(make-operation "/")))

          
;;; operation-name : Operation -> OperationName
;;; GIVEN: an operation
;;; RETURNS: the name of that operation
;;; EXAMPLES:
;;;     (operation-name (op "+")) => "+"
;;;     (operation-name (op "/")) => "/"

;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(operation-name (op "+"))"+" "x5 should be returned")
  (check-equal?(operation-name (op "*"))"*" "tpk should be returned"))

;;;;REPRESENTATION : A Caller struct can be represented as
;;(make-caller x lst)
;; with the following fields-
;;x : ArithmeticExpression 
;;lst : ArithmeticExpressionList

;;IMPLEMENTATION:
(define-struct caller(x lst))

;;CONSTRUCTOR TEMPLATE:
;;(make-caller ArithmeticExpression ArithmeticExpressionList)

;;OBSERVER TEMPLATE :
;;;; caller-fn :Caller -> ?
;;(define (caller-fn l)
;; (...
;;  (caller-x l)
;;(caller-lst l)))
          
;;; call : ArithmeticExpression ArithmeticExpressionList -> Call
;;; GIVEN: an operator expression and a list of operand expressions
;;; RETURNS: a call expression whose operator and operands are as
;;;     given
;;; EXAMPLES: (call (op "-")(list (lit 7) (lit 2.5)))->
;;(make-caller (make-operation "-") (list (make-literal 7) (make-literal 2.5)))
;;;STRATEGY: Use the constructor template for Caller
(define(call oprtr lst1)
  (make-caller oprtr lst1))
;;TESTS:
(begin-for-test
  (check-equal? (call (op "+")(list (lit 17)))
                (make-caller (make-operation "+") (list (make-literal 17))))
  (check-equal? (call (op "/")(list (lit 17)(lit 4)))
                (make-caller (make-operation "/")
                             (list (make-literal 17)(make-literal 4)))))
;;; call-operator : Call -> ArithmeticExpression
;;; GIVEN: a call
;;; RETURNS: the operator expression of that call
;;; EXAMPLE: (call-operator (call (op "-")
;;;                          (list (lit 7) (lit 2.5))))
;;;

;;;         => (op "-")
;;;STRATEGY : Use the constructor template for Caller
(define(call-operator cal)
  (caller-x cal))
;;TESTS:
(begin-for-test
  (check-equal? (call-operator(call (op "+")(list (lit 17))))
                (make-operation "+"))
  (check-equal? (call-operator(call (op "/")(list (lit 17)(lit 4))))
                (make-operation "/") ))        
;;; call-operands : Call -> ArithmeticExpressionList
;;; GIVEN: a call
;;; RETURNS: the operand expressions of that call
;;; EXAMPLE:
;;;     (call-operands (call (op "-")
;;;                          (list (lit 7) (lit 2.5))))
;;;         => (list (lit 7) (lit 2.5))
;;;STRATEGY : Use the constructor template for Caller

(define(call-operands cal)
  (caller-lst cal))
;;TESTS:
(begin-for-test
  (check-equal? (call-operands(call (op "+")(list (lit 17))))
                (list (lit 17) ))
  (check-equal? (call-operands(call (op "/")(list (lit 17)(lit 4))))
                (list (lit 17) (lit 4)) ))

;;;;REPRESENTATION : A Bloc struct can be represented as
;;(make-bloc v ae ae1)
;; with the following fields-
;;v : Variable which represents the variable of the block
;;ae : ArithmeticExpression which represents the expression of the block
;;ae1 : ArithmeticExpression which represents the expression of the block

;;IMPLEMENTATION:
(define-struct bloc(v ae ae1))

;;CONSTRUCTOR TEMPLATE:
;;(make-block variable Arithmeticexpression Arithmeticexpression)

;;OBSERVER TEMPLATE :
;;;; bloc-fn :Bloc -> ?
;;(define (bloc-fn l)
;; (...
;;  (bloc-v l)
;;(bloc-ae l)
;;(bloc-ae1 l)))
          
;;; block : Variable ArithmeticExpression ArithmeticExpression
;;;             -> ArithmeticExpression
;;; GIVEN: a variable, an expression e0, and an expression e1
;;; RETURNS: a block that defines the variable's value as the
;;;     value of e0; the block's value will be the value of e1
;;; EXAMPLES: (block (var "x5")
;;                       (lit 5)
;;                      (call (op "*")
;;                           (list (var "x6") (var "x7"))))
;;(make-bloc (make-variable "x5") (make-literal 5)
;;(make-caller (make-operation "*") (list (make-variable "x6")
;;(make-variable "x7"))))
;;;STRATEGY: Use the constructor template for Bloc

(define (block v e0 e1)
  (make-bloc v e0 e1))
;;TESTS:
(begin-for-test
  (check-equal? (block (var "x5")
                       (lit 5)
                       (call (op "*")
                             (list (var "x6") (var "x7"))))
                (make-bloc (make-variable "x5") (make-literal 5)
                           (make-caller (make-operation "*")
                                        (list (make-variable "x6")
                                              (make-variable "x7")))) ))
(begin-for-test
  (check-equal? (block (var "x5")
                       (block (var "x7")(lit 4)(call (op "*")
                                                     (list (var "x6")
                                                           (var "x7"))))
                       (call (op "*")
                             (list (var "x6") (var "x7"))))
                (make-bloc
                 (make-variable "x5")
                 (make-bloc (make-variable "x7") (make-literal 4)
                            (make-caller (make-operation "*")
                                         (list (make-variable "x6")
                                               (make-variable "x7"))))
                 (make-caller (make-operation "*")
                              (list (make-variable "x6")
                                    (make-variable "x7"))))))

  
;;; block-var : Block -> Variable
;;; GIVEN: a block
;;; RETURNS: the variable defined by that block
;;; EXAMPLE:
;;;     (block-var (block (var "x5")
;;;                       (lit 5)
;;;                       (call (op "*")
;;;                             (list (var "x6") (var "x7")))))
;;;         => (var "x5")
;;;STRATEGY: Use the constructor template for Bloc
(define(block-var b)
  (bloc-v b))
;;TESTS:
(begin-for-test
  (check-equal? (block-var (block(var "x5")
                                 (lit 5)
                                 (call (op "*")
                                       (list (var "x6") (var "x7")))))
                (make-variable "x5") )
  (check-equal? (block-var(block (var "x0")
                                 (block (var "x7")
                                        (lit 4)
                                        (call (op "*")
                                              (list (var "x6") (var "x7"))))
                                 (call (op "*")
                                       (list (var "x6") (var "x7")))))
                (make-variable "x0")))

          
;;; block-rhs : Block -> ArithmeticExpression
;;; GIVEN: a block
;;; RETURNS: the expression whose value will become the value of
;;;     the variable defined by that block
;;; EXAMPLE:
;;;     (block-rhs (block (var "x5")
;;;                       (lit 5)
;;;                       (call (op "*")
;;;                             (list (var "x6") (var "x7")))))
;;;         => (lit 5)
;;;STRATEGY: Use the constructor template for Bloc
(define(block-rhs b)
  (bloc-ae b))
;;TESTS
(begin-for-test
  (check-equal? (block-rhs (block(var "x5")
                                 (lit 5)
                                 (call (op "*")
                                       (list (var "x6") (var "x7")))))
                (make-literal 5))
  (check-equal? (block-rhs(block (var "x0")
                                 (block (var "x7")(lit 4)
                                        (call (op "*")
                                              (list (var "x6") (var "x7"))))
                                 (call (op "*")
                                       (list (var "x6") (var "x7")))))
                (make-bloc (make-variable "x7") (make-literal 4)
                           (make-caller (make-operation "*")
                                        (list (make-variable "x6")
                                              (make-variable "x7"))))))
          
;;; block-body : Block -> ArithmeticExpression
;;; GIVEN: a block
;;; RETURNS: the expression whose value will become the value of
;;;     the block expression
;;; EXAMPLE:
;;;     (block-body (block (var "x5")
;;;                        (lit 5)
;;;                        (call (op "*")
;;;                              (list (var "x6") (var "x7")))))
;;;         => (call (op "*") (list (var "x6") (var "x7")))
;;;STRATEGY: Use the constructor template for Bloc
(define(block-body b)
  (bloc-ae1 b))

;;TESTS
(begin-for-test
  (check-equal? (block-body (block(var "x5")
                                  (lit 5)
                                  (call (op "*")
                                        (list (var "x6") (var "x7")))))
                (make-caller (make-operation "*")
                             (list (make-variable "x6") (make-variable "x7"))))
  (check-equal? (block-body(block (var "x0")
                                  (block (var "x7")
                                         (lit 4)
                                         (call (op "*")
                                               (list (var "x6")
                                                     (var "x7"))))
                                  (call (op "-")
                                        (list (var "x9") (var "x1")))))
                (make-caller (make-operation "-")
                             (list (make-variable "x9") (make-variable "x1")))))

;;; literal?   : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is literal
;;STRATEGY: Use the constructor template for Literal
;;; EXAMPLES:
;;;   (literal?  (lit 4))->true
;;TESTS
(begin-for-test
  (check-equal? (literal? (lit 7)) true)
  (check-equal? (literal? (var 7)) false) )

;;; variable?  : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is variable
;;STRATEGY: Use the constructor template for Variable
;;; EXAMPLES:
;;;   (variable?  (var "4"))->true
;;TESTS
(begin-for-test
  (check-equal? (variable? (var "7")) true)
  (check-equal? (variable? (lit 7)) false))
;;; operation? : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is operation
;;STRATEGY: Use the constructor template for Operation
;;; EXAMPLES:
;;;   (operation?  (op "+"))-> true
;;TESTS
(begin-for-test
  (check-equal? (operation? (op "-")) true)
  (check-equal? (operation? (var "bcvbcv")) false))

;;; call?      : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is call
;;; EXAMPLES:
;;;   (call?  (call (op "-")
;;                           (list (var "x9") (var "x1")))->true
;;STRATEGY: Use the constructor template for Call
(define (call? e)
  (caller? e))

;;TESTS:
(begin-for-test
  (check-equal?(call?(call (op "*")
                           (list (var "x6") (var "x7"))))true))

;;; block?     : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is block
;;; EXAMPLES:
;;;   (block? (block (var "x5")
;;                  (lit 5)
;;                (call (op "*")
;;                   (list (var "x6") (var "x7")))))->true
;;STRATEGY: Use the constructor template for Block
(define (block? bl)
  (bloc? bl))
;;TESTS
(begin-for-test
  (check-equal?(block? (block-body (block(var "x5")
                                         (lit 5)
                                         (call (op "*")
                                               (list
                                                (var "x6")
                                                (var "x7"))))))
               false"false should
be returned")

  (check-equal?(block? (block (var "x5")
                              (lit 5)
                              (call (op "*")
                                    (list (var "x6")
                                          (var "x7")))))true"true should be
returned"))


          
;;; undefined-variables : ArithmeticExpression -> StringList
;;; GIVEN: an arbitrary arithmetic expression
;;; RETURNS: a list of the names of all undefined variables
;;;     for the expression, without repetitions, in any order
;;; EXAMPLE:
;;;     (undefined-variables
;;;      (call (var "f")
;;;            (list (block (var "x")
;;;                         (var "x")
;;;                         (var "x"))
;;;                  (block (var "y")
;;;                         (lit 7)
;;;                         (var "y"))
;;;                  (var "z"))))
;;;  => some permutation of (list "f" "x" "z")
;;STRATEGY: Call a more general function
  
(define (undefined-variables ae )
  (undefined-conditions ae empty))
;;undefined-conditions: ArithmeticExpression DvarList->StringList
;;GIVEN: An arithmetic expression DvarList
;;WHERE:DVarsList is the list of variables available at the start of ae
;;RETURNS:List of undefined variables
;;STRATEGY:Use observer template of ArithmeticExpression
;;EXAMPLES: (undefined-conditions(block(var"x")(var"y")(var"z"))empty)
;(list "y" "z")
(define(undefined-conditions ae  dlist )
  (cond
    [(literal? ae) null ]
    [(variable? ae)(check-variable-uv ae dlist )]
    [(call? ae)(check-call-uv ae  dlist)]
    [(block? ae) (check-block-uv ae dlist)]
    [(operation? ae)null]))

;;check-block:ArithmeticExpression DvarList->StringList
;;GIVEN: An arithmetic expression DvarList
;;WHERE: The dlist now has the block-variables
;;RETURNS:Lsit of undefined variables
;;STRATEGY:Observer template of block
;;EXAMPLES:
; (check-block-uv(block(var"x")(var"y")(var"z"))(list(var"x")))->
;(list "y" "z")
(define(check-block-uv ae dlist)
  (append
   (undefined-conditions(block-rhs ae )  dlist)
   (undefined-conditions(block-body ae)
                        (cons (variable-name( block-var ae)) dlist))))
;;remove-duplicates lst :  List->List
;;GIVEN: List which has the duplicates
;;RETURNS : List without the duplicates
;;STRATEGY: Use the observer template of the list
;;EXAMPLES:(remove-duplicates (list "x" "y" "x" "z"))->
;;(list "y" "x" "z")
(define(remove-duplicates lst)
  (cond
    [(empty? lst)empty]
    [(member? (first lst)(rest lst))
     (remove-duplicates(rest lst))]
    [else(cons(first lst)(remove-duplicates(rest lst)))]))
;;TESTS:
(begin-for-test
  (check-equal?(remove-duplicates (list "a" "a" "a" "z"))(list "a" "z")"list
without the duplicates should be returned"))

;;check-variable:ArithmeticExpression DvarList->StringList
;;GIVEN: An arithmetic expression DvarList
;;RETURNS:Lsit of undefined variables
;;STRATEGY:Observer template of variable
;;EXAMPLES:(check-variable-uv (var"x")(list))->
;(list "x")
(define (check-variable-uv bvar dlist)
  (if
   (member? (variable-name bvar) dlist)
   null
 ( remove-duplicates (cons (variable-name bvar)empty))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;check-call:ArithmeticExpression DvarList->StringList
;;GIVEN: An arithmetic expression DvarList
;;RETURNS:Lsit of undefined variables
;;STRATEGY:Observer template of ca;;
(define(check-call-uv ae dlist)
  (append
   (undefined-conditions(call-operator ae)dlist)
   (variables-lst2(call-operands ae)dlist)empty))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;variables-lst2:ArithmeticExpressionList DvarList->StringList
;;GIVEN: An arithmetic expressionList DvarList
;;RETURNS:Lsit of undefined variables
;;STRATEGY:Observer template of call
;;EXAMPLES:(variables-lst2
;(list (block (var "x") (lit 5)
; (var "z")))(list(var"y")))
;->(list "z")
(define(variables-lst2 l dlist)
  (cond
    [ (empty? l )null]
    [else(append (undefined-conditions(first l) dlist)
                 (variables-lst2(rest l) dlist))]))



;TESTS:
(begin-for-test
  (check-equal?
   (undefined-variables
    (call (var "f")
          (list (block (var "x")
                       (var "x")
                       (var "x"))
                (block (var "y")
                       (lit 7)
                       (var "y"))
                (var "z"))))
   (list "f" "x" "z")
   ))
(begin-for-test
  (check-equal? (undefined-variables
                 (call (var "f")
                       (list (block (var "x")
                                    (var "x")
                                    (var "x"))
                             (block (var "y")
                                    (lit 7)
                                    (var "y"))
                             (op "/") )))
                (list "f" "x" )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; well-typed? : ArithmeticExpression -> Boolean
;;; GIVEN: an arbitrary arithmetic expression
;;; RETURNS: true if and only if the expression is well-typed
;;; EXAMPLES:
;;;     (well-typed? (lit 17))  =>  true
;;;     (well-typed? (var "x"))  =>  false
;;;
;;;     (well-typed?
;;;      (block (var "f")
;;;             (op "+")
;;;             (block (var "x")
;;;                    (call (var "f") (list))
;;;                    (call (op "*")
;;;                          (list (var "x"))))) => true
;;;
;;;     (well-typed?
;;;      (block (var "f")
;;;             (op "+")
;;;             (block (var "f")
;;;                    (call (var "f") (list))
;;;                    (call (op "*")
;;;                          (list (var "f"))))) => true
;;;
;;;     (well-typed?
;;;      (block (var "f")
;;;             (op "+")
;;;             (block (var "x")
;;;                    (call (var "f") (list))
;;;                    (call (op "*")
;;;                          (list (var "f"))))) => false


;;STRATEGY: Call a more general fn
(define(well-typed? ae)
  (if (string=? (type-checker empty ae) ERROR)false
      true))
;;type-checker: List ArithmeticExpression->Type
;;GIVEN: A List and  ArithmeticExpression
;;RETURNS: The type of the ae
;;WHERE: The list is the list of variables which is initially empty
;;STRATEGY: Use observer template of arithmetic expression
;;EXAMPLES:(type-checker (list)(block(var"x")(var"y")(var"Z")))
;->"error"
(define(type-checker l ae)
  (cond
    [(literal? ae)INT]
    [(operation? ae) (operation-checker l ae)]
    [(call? ae)(call-checker l ae)]
      [(variable? ae)(variable-checker l ae)]
    [(block? ae) (block-checker l ae)]
  ))
;;operation-checker: List AirthmeticExpression->Type
;;GIVEN: A List and  ArithmeticExpression
;;RETURNS: The type of the ae
;;STRATEGY: Use observer template of operation-name
;;EXAMPLES: (operation-checker (list)(op "+"))
;->"op0"
(define(operation-checker l ae)
  (cond
    [(equal? (operation-name ae) "+")OP0]
    [(equal? (operation-name ae) "-")OP1]
    [(equal? (operation-name ae) "*")OP0]
    [(equal? (operation-name ae) "/")OP1]))

;;call-checker: List AirthmeticExpression->Type
;;GIVEN: A List and  ArithmeticExpression
;;RETURNS: The type of the ae
;;STRATEGY: Use observer template of the call
;;EXAMPLES:(call-checker (list(var "x"))(call (op"/")
            ;          (list(lit 4)(lit 5))))
;->"int"
(define(call-checker l ae)
  (cond
    [(and
      (string=? (type-checker l(call-operator ae))OP0)
      (opl l(call-operands ae)))
     INT]
    [(and
      (string=? (type-checker l(call-operator ae ))OP1)
      (not (null? (call-operands ae)))
      (opl l (call-operands ae )))
     INT]
    [else ERROR]))
;;TESTS
(begin-for-test
  (check-equal? (call-checker (list(var "x"))(call (op"/")
                      (list(lit 4)(lit 5))))
"int")
 (check-equal? (call-checker (list(var "x"))(call (op"-")
                      (list(lit 4)(lit 5))))
"int") )
;;opl: List ArithmeticExpressionList->Type
;;GIVEN: A List and  ArithmeticExpressionList
;;RETURNS: The type of the ae
;;STRATEGY: Use observer template of the call
;;EXAMPLES: (opl (list(lit 4)(lit 5)) (list(lit 5 )(lit 8)))
;->#true
(define(opl  l opli)
  (cond
    [(empty? opli) true]
    [else(and
          (string=? (type-checker l(first opli)) INT)
          (opl l(rest opli) ))]))
;;variable-checker: List ArithmeticExpression->Type
;;GIVEN: A List and  ArithmeticExpression
;;RETURNS: The type of the ae
;;STRATEGY: Use observer template of the variable 
(define(variable-checker l ae)
  (cond
    [(empty? l) ERROR]
    [(in-list?  (first l)ae) (var-ty-type (first l))]
    [else (variable-checker (rest l)ae)]))
;;block-checker: List ArithmeticExpression->Type
;;GIVEN: A List and  ArithmeticExpression
;;RETURNS: The type of the ae
;;WHERE: the variables are being appended to the list
;;STRATEGY: Use observer template of the block
;;EXAMPLES:(type-checker(list)(block(var"x")
;;(var"y")(var"z")))
;;->"error")
(define (block-checker l ae)
  (cond
    [(string=? (type-checker l(block-rhs ae))ERROR) ERROR]
    [else
     (type-checker(listofstrucs(block-var ae)(type-checker 
                                              l(block-rhs ae))
                               l)
                  (block-body ae))]))
;;TESTS:
(begin-for-test
  (check-equal? (type-checker(list)(block(var"x")(var"y")(var"z")))
"error"))
;;listofstrucs: ArithmeticExpression Type  LIst >Type
;;GIVEN: ArithmeticExpression Type  LIst
;;RETURNS: The list of the variables
;;WHERE: Conditionally variables are appended
;;STRATEGY: Use  observer template of the list
(define (listofstrucs v t l)
  (cond
    [(empty? l)(cons(make-var-ty(variable-name v) t) l)]
    [(in-list? (first l) v)(cons(make-var-ty(variable-name v)t)
                                (rest l))]
  
    [else(cons(first l)(listofstrucs v t (rest l)))]))

   
;;in-list?: Variable Variable->Boolean
;;GIVEN: Variables
;;RETURNS: True/False if both the variables are same
;;STRATEGY: Using string fn 
(define (in-list? ae v)
  (string=? (var-ty-var ae) (variable-name  v)))

;;TESTS
(begin-for-test
  (check-equal? (well-typed? (lit 17)) true)
  (check-equal? (well-typed? (var "x")) false)
  (check-equal? (well-typed?
                 (block (var "f")
                        (op "+")
                        (block (var "x")
                               (call (var "f") (list))
                               (call (op "*")
                                     (list (var "x")))))) true)
   (check-equal? (well-typed?
         (block (var "f")
                (op "+")
                (block (var "f")
                       (call (var "f") (list))
                       (call (op "*")
                             (list (var "f")))))) true)
   
      (check-equal?   (well-typed?
         (block (var "f")
                (op "+")
                (block (var "x")
                       (call (var "f") (list))
                       (call (op "*")
                             (list (var "f"))))))false))

  


 
  
 

  
                   

 
  
              
 


   
