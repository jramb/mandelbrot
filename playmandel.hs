#!/usr/bin/runghc
-- This very impressive Haskell program by jramb/2013-03-14 (pi-day)
-- Continued 2015
-- Run uncompiled (much slower):
--   runghc playmandel.hs 140 50 10000
-- Compile: ghc -o playmandel playmandel.hs -O2
--          time ./playmandel 140 50 10000
-- rm playmandel.o && ghc -o playmandel playmandel.hs -O2 && time ./playmandel 140 50 10000
-- Profile: ghc -prof -auto-all -o playmandel playmandel.hs
--          time ./playmandel 140 50 10000 +RTS -p
--
-- TODO Haskell: check out Data.Complex?
-------------------------------------
{-# OPTIONS_GHC -Wall #-}
import System.Environment -- (getArgs)

-- constructor for Complex: r :+ i
infixr 5 :+
data Complex = Float :+ Float
  {-deriving (Show)-}
{-type Complex = (Float,Float)-}

instance Show Complex where
  show (r :+ i) = show $ show r++" :+ "++show i

{-instance (Num a,Num b) => (a :+ b) where-}
  {-(r1 :+ i1) + (r2 :+ i2) = (r1+r2) :+ (i1+i2)-}
  {-(r1 :+ i1) * (r2 :+ i2) = (r1*r2 -(i1*i2)) :+ (i1*r2+r1*i2)-}
  {-Pair (a,b) + Pair (c,d) = Pair (a+c,b+d)-}
  {-Pair (a,b) * Pair (c,d) = Pair (a*c,b*d)-}
  {-Pair (a,b) - Pair (c,d) = Pair (a-c,b-d)-}
  {-abs    (Pair (a,b)) = Pair (abs a,    abs b) -}
  {-signum (Pair (a,b)) = Pair (signum a, signum b) -}
  {-fromInteger i = Pair (fromInteger i, fromInteger i)-}

complexMul :: Complex -> Complex -> Complex
complexMul (r1 :+ i1) (r2 :+ i2)
           = (r1*r2 -(i1*i2)) :+ (i1*r2+r1*i2)

complexSqr :: Complex -> Complex
complexSqr c = complexMul c c

complexAdd :: Complex -> Complex -> Complex
(r1 :+ i1)  `complexAdd` (r2 :+ i2)  = (r1+r2) :+ (i1+i2)

largerThan2 :: Complex -> Bool
largerThan2 (r :+ i)  = (r*r + i*i) > 4

-- Pc : z |-> z^2 + c
mandelseq :: Complex -> Complex -> [Complex]
mandelseq c z
          | largerThan2 z = []
          | otherwise = let z' = complexSqr z `complexAdd` c
                        in z' :  mandelseq c z'

lengthMandelChain :: Int -> Complex -> Int
lengthMandelChain limit c = length . take limit $ mandelseq c (0 :+ 0)
--                    lenght ( take limit ( mandelseq c (0,0)))

ranger :: Float -> Float -> Int -> [Float]
{-ranger s e steps = init [s,(s+((e-s)/fromIntegral steps))..e]-}
ranger s e steps =
    [s + fromIntegral x*w | x <- [0,1..pred steps]]
    where w = (e-s)/fromIntegral steps


concatWithCR :: String -> String -> String
concatWithCR x acc = x ++ "\n" ++ acc

calcMandel :: Int -> Int -> Int -> String
calcMandel width height mx =
   foldr1 concatWithCR $ --(\x acc -> x++"\n"++acc) $
           ( map calcRow $ ranger (-1) 1 height )
           {-[ calcRow x | x <- ranger (-1) 1 height ]-}
       where calcRow :: Float -> String
             mandelTest c = (lengthMandelChain mx c) >= mx
             calcRow y = map (calcCell y) $ ranger (-2) 1 width
             calcCell :: Float -> Float -> Char
             calcCell y x = if mandelTest (x :+ y) then '*' else '-'

-- MAIN
main :: IO ()
main = do
     args <- getArgs
     {-putStrLn $ show (0.2 :+ (-2.1))-}
     let (w:h:mx:_) = args
         w' = read w::Int
         h' = read h::Int
         mx' = read mx::Int in do
            putStrLn $ show (w', h', mx') --args
            let output = calcMandel w' h' mx' in --70 30 1000
                    putStrLn $ output
