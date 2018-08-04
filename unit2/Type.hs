module Type where

{-
This definition will not work
myAverage aList = sum aList / length aList Because the list can contain any kind of type and is not limited to
numbers
-}

{-A type in haskell cab be defined in this way
All types in Haskell start with a capital letter to distinguish them from functions-}
a :: Int
a = 2

-- Int is a bounded type, if I want an unbounded i have to use Integer
b :: Integer
b = 1000000000000

{-
The result of being bounded or unbounded can be seen doing this
b^2000 and a^2000 where with b you will have the result and a will be zero-}

-- This is a list of int
values :: [Int]
values = [1,2,3]

-- This is a tuple with type specified
ageAndHeight :: (Int,Int)
ageAndHeight = (25,180)


-- I can have function types too

doubleTheNumber :: Integer -> Integer
doubleTheNumber = (\a -> a*2)

doubleTheNumberNotLambda :: Integer -> Integer
doubleTheNumberNotLambda a = a*2

-- This function will divide by half
half :: Int -> Double
{-
Would be natural to do this: half n = n/2 but will result in a compilation error
because we are trying to divide an Integer
haskell doesn't cast type for you and you need to explicitly use an haskell function to make it work
-}
half n = (fromIntegral n) / 2

-- The show function is the equivalent of a toString
toStringDouble :: Integer -> String
toStringDouble = (\a -> show (a*2))

{-
The read function is for parsing a String. The result type can be decided from the haskell compiler
according to the use that you will do, otherwise you need to explicitly declare the type
-}
parsedString = read "9"

add1ToParsed = parsedString + 1 -- Since i'm using the variable the haskell compile knows that need to be an Int

{-Another key component that is need to use have generic type to use, if for example i want to define a
function which return the same type of the input without any restriction
For example for Int will be Int -> Int for String String -> String and so on. I need to be able to express
that the return type is the same as input. For doing that i can use type variable-}
simple :: a -> a
simple x = x

{-
For example if a want to define a funciton that make a tuple from three differnt type i can do this
-}

makeTuple :: a -> b -> c -> (a,b,c)
makeTuple = (\a b c  -> (a,b,c))