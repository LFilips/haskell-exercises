-- Simple definition of function and lambda function

{-
This is a simple function wich sum two Integer value
I haven't studyied the haskell type system but it is statically typed,
so the type of this function is resolved at compile type. We can use
the :type instruction to get the type of a function and in the case of this
one we will have:
type myfunction ==> myfunction :: Num a => a -> a -> a
-}
myfunction a b = a+b

{-
In this case i'm defining a lambda function
In this case if i do the :info or :type i get that the type is
mylambda :: Integer -> Integer -> Integer
This haskell definition is probably due to the connection with lambda
calculus and the that each function only had 1 param, so in this case for having
this two param it is the a -> b -> c
-}
mylambda = (\a b -> a+b)

{-
If i curry this function the type will be
mylambdaCurried :: Integer -> Integer because i've already provided one of the param
-}
mylambdaCurried = mylambda 1