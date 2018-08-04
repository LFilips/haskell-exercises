-- Modelling a cup object using haskell. The only property that i need for the cup object is its size.

{-|
  This will be the constuctor of the cup, that will allow me to pass a message
  to my object and to do something with the value that i'm storing!
  With this notation what I'm saying that I'm defining a function cup that will take
  a param. The result of the function cup will be a 1 parameter lambda function
  that will apply that function to the flOz
-}
cup flOz = \message -> message flOz

{-| In this way I can create a coffeCup obect with in this way:-}
coffeeCup = cup 12

{- Thanks to how i've defined the constructor I can define a getter method
   The getter method is obtained passing as a message for the cup obect a lambda
   function wich takes as parameter a flOz, what is happening is this:
   cup flOz = \message -> message flOz
   where message is a lambra function with a parameter which gives back the input
   = (\flOz -> flOz). In my case the input is the flOz, this is how i can obtain
   the effect of a getter and why is important the ability to send a message in
   the constuctor
-}
getOz aCup = aCup (\flOz -> flOz)

{- How i could be able to drink something from the cup and reduce the size since
  i don't have any object in memory?
  What I have to do is to create a new object where the size of the cup is the
  original - the value that i want to drink
  -}
drink aCup ozDrank = cup (flOz - ozDrank)
    where flOz = getOz aCup
