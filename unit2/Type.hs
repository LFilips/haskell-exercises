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


{-
Another important component of the haskell type system are the type synonyms which are the same as type alias in scala
let's consider for example this function that will print the information of a patient having as imput
name surname height ann age. This natural definition of this is the following:
-}
patientInfo :: String -> String -> Int -> Int -> String
patientInfo fname lname age height = name ++ " " ++ ageHeight
 where name = lname ++ ", " ++ fname
       ageHeight = "(" ++ show age ++ "yrs. " ++ show height ++ "in.)"

{-
The previous definition will not help us to understand what is happening in the function, so the type synonyms came to
rescue and we can use that to better understand the type of the function
-}
type FirstName = String
type LastName = String
type Age = Int
type Height = Int

patientInfoWithTypeSynonym :: FirstName -> LastName -> Age -> Height -> String
patientInfoWithTypeSynonym fname lname age height = name ++ " " ++ ageHeight
 where name = lname ++ ", " ++ fname
       ageHeight = "(" ++ show age ++ "yrs. " ++ show height ++ "in.)"

-- I can define a type for FirstName and secondName

type PatientName = (String,String)
-- And then define helper function for getting first and lastname

firstName :: PatientName -> String
firstName aPatienteName = fst aPatienteName -- Haskell function for getting the first element of a tuple

lastName :: PatientName -> String
lastName aPatientname = snd aPatientname

{-
What i've defined before are just type synonyms, if i want to create a brand new type I have to use
the data keywork
-}
data Sex = Male | Female

{-
The boolean type is defined in this way in haskell
data Boolean = True | False
-}


{-A most complicated example can be to define the boold type of a person.
The ABO blood type can have four values: A, B, AB, or O. This refers to the family of antibodies in the blood.
The positive or negative part refers to the person’s Rhesus (Rh) group, which indicates the presence or absence of a
particular antigen. Modellying all the cases can be complication, istead we can mix the definition-}

data RhType = Pos | Neg
data ABOType = A | B | AB | O
data BloodType =  BloodType ABOType RhType

-- Now i can construct blood type

orhnegative = BloodType O Neg


{-
Another core concept are the type classe. That are generic class that can be used from more that one type
like for example the list inteface in java that can be used by different implementation. In haskell we can see
the Num type as a type classes and we can get information out of it from the info command. The type
classes can be seen as interface in the oop, since you can define method that belong to tha type
As example this is the describable type class, which has a method describe that is used for describing that type
-}

class Describable a where
    describe :: a -> String

{-let't take as example the show type classe:
:info show
class Show a where
  ...
  show :: a -> String
  ...
        -- Defined in ‘GHC.Show’
It only has one function that is show.
-}



-- this is an example of the iceCream clas
data Icecream = Chocolate | Vanilla

{-
if i want to do the show for this classes in the ghci i need the show function
What we can do is to let haskell derive the type class for show in this way
-}

data DomesticAnimal = Cat | Dog deriving (Show)

{-I can add more derived class, seems to be like when with java implement and Inteface or with a Trait in scala-}

data Seasoning = Oregano | Basil deriving (Show,Eq, Ord)

{-All this type class had a default behaviour for the derived implementation, for example in the case of the ord
the order is given by the order of the declaration in the data constructor. Unfortunately this is not enough, because
would be good to define an instance of the type class and to override the default behaviour. Another exaple it a 6 faced dice
-}

data SixSidedDice = S1 | S2 | S3 | S4 | S5 | S6 -- deriving Show

{-I need to define an instance for the show!-}

instance Show SixSidedDice where
    show S1 = "1"
    show S2 = "2"
    show S3 = "3"
    show S4 = "4"
    show S5 = "5"
    show S6 = "6"


{-Another interesting instance to define is the eq-}

instance Eq SixSidedDice where
   (==) S6 S6 = True
   (==) S5 S5 = True
   (==) S4 S4 = True
   (==) S3 S3 = True
   (==) S2 S2 = True
   (==) S1 S1 = True
   (==) _ _ = False

{-thanks to the default implementation of method is enough to define the equals as the not equals is the opposite
This is common pattern especially in algebraic data structure where you can define method in terms of the other and
then have a full implementation just defining one method (like map and flatmap for Monads)-}

{-How I can know which is the minimum viable implementation for type classes? Though hoogle i can search in the package
and know what to implement or i can use :info. If for example i want to implement the Ord for my dice using the
info command this is what i get   {-# MINIMAL compare | (<=) #-} this means that the minal implementation should be
the compare or the lessEqual. compare is defined as:   compare :: a -> a -> Ordering where ordering is
data Ordering = LT | EQ | GT
 -}


instance Ord SixSidedDice where
    compare S6 S6 = EQ
    compare S6 _ = GT -- if the pattern matching goes after this,means that i don'thave a six
    compare _ S6 = LT
    compare S5 S5 = EQ -- This means that I can safely use the five as upped bound
    compare S5 _ = GT
    compare _ S5 = LT
    compare S4 S4 = EQ
    compare S4 _ = GT
    compare _ S4 = LT
    compare S3 S3 = EQ
    compare S3 _ = GT
    compare _ S3 = LT
    compare S2 S2 = EQ
    compare S2 _ = GT
    compare _ S2 = LT
    compare S1 S1 = EQ


{-But since we know that is possible to use the derived version that infers from the data constructor we
can have a version of the dice fully derived-}

data DerivedSixSidedDie = S1 | S2 | S3 | S4 | S5 | S6 deriving (Show,Eq,Ord)

{-That will follow the order of the data constructor for the ordering and-}



