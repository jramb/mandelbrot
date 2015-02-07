-- This very impressive Haskell program by jramb/2013-03-14 (pi-day)
-- Compile: ghc -o playmandel playmandel.hs -O3
--          time ./playmandel 140 50 10000
-- rm playmandel.o && ghc -o playmandel playmandel.hs -O2 && time ./playmandel 140 50 10000
-- Profile: ghc -prof -auto-all -o playmandel playmandel.hs
--          time ./playmandel 140 50 10000 +RTS -p
--
-- TODO Haskell: check out Data.Complex? Spoils the fun, maybe
-------------------------------------
import System.Environment -- (getArgs)

type Complex = (Double,Double)

complexMul :: Complex -> Complex -> Complex
complexMul (r1,i1) (r2,i2)
           = ((r1*r2)-(i1*i2),i1*r2+r1*i2)
--   beware of the - ^

complexSqr :: Complex -> Complex
complexSqr c = complexMul c c
{-complexSqr (r,i) = (r*r-i*i,2*i*r) --faster(?) but boring-}

complexAdd :: Complex -> Complex -> Complex
complexAdd (r1,i1) (r2,i2) = (r1+r2,i1+i2)

largerThan2 :: Complex -> Bool
largerThan2 (r,i) = (r*r + i*i)>4

-- Pc : z |-> z^2 + c
mandelseq :: Complex -> Complex -> [Complex]
mandelseq c z
          | largerThan2 z = []
          | otherwise = let z' = p c z
                        in z' :  mandelseq c z'
          where p c z = complexSqr z `complexAdd` c

isMandelGen :: Int -> Complex -> Int
isMandelGen limit c = length . take limit $ mandelseq c (0,0)
--                    lenght ( take limit ( mandelseq c (0,0)))

ranger :: Double -> Double -> Int -> [Double]
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
       where calcRow :: Double -> String
             mandelTest c = (isMandelGen mx c) >= mx
             calcRow y = map (calcCell y) $ ranger (-2) 1 width
             calcCell :: Double -> Double -> Char
             calcCell y x = if mandelTest (x,y) then '*' else '-'

-- MAIN
main = do
     args <- getArgs
     let (w:h:mx:_) = args
         w' = read w::Int
         h' = read h::Int
         mx' = read mx::Int in do
           putStrLn $ show (w', h', mx') --args
           let output = calcMandel w' h' mx' in --70 30 1000
                    putStrLn $ output
