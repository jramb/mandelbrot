-- This very impressive Haskell program by jramb/2013-03-14 (pi-day)
-- Compile: ghc -o playmandel playmandel.hs
--          time ./playmandel 140 50 10000
-- Profile: ghc -prof -auto-all -o playmandel playmandel.hs
--          time ./playmandel 140 50 10000 +RTS -p
import System.Environment -- (getArgs)

type Complex = (Double,Double)

complexMul :: Complex -> Complex -> Complex
complexMul (r1,i1) (r2, i2)
           = (r1*r2-i1*i2,i1*r2+r1*i2)

complexSqr :: Complex -> Complex
--complexSqr c = complexMul c c
complexSqr (r,i) = (r*r-i*i,2*i*r) --faster(?) but boring

complexAdd :: Complex -> Complex -> Complex
complexAdd (r1,i1) (r2,i2) = (r1+r2,i1+i2)

--largerThan2 :: Complex -> Bool
--largerThan2 (r,i) = (r*r + i*i)>4

-- Pc : z |-> z^2 + c
mandelseq :: Complex -> Complex -> [Complex]
mandelseq c z
          | largerThan2 z = []
          | otherwise = let z' = p c z
                        in z' :  mandelseq c z'
          where p c z = complexAdd (complexSqr z) c
                --p' (cr,ci) (zr,zi) = (zr*zr-zi*zi+cr,2*zi*zr+ci) -- THIS is SLOWER!
                largerThan2 (r,i) = (r*r + i*i)>4

isMandelGen :: Int -> Complex -> Int
isMandelGen limit c = length . take limit $ mandelseq c (0,0)
--                    lenght ( take limit ( mandelseq c (0,0)))

isMandel = isMandelGen 10000

mandelTest c mx = (flip isMandelGen c mx) >= mx

ranger :: Double -> Double -> Double -> [Double]
ranger s e step = init [s,(s+((e-s)/step))..e]

-- ranger (-2) 1 70
-- ranger (-1) 1 30
-- make a sequence of this, find points c where sequence stays <=2
-- xs = init [-2,(-2+(3/70))..1]
-- ys = init [-1,(-1+(2/30))..1]

calcMandel :: Double -> Double -> Int -> String
calcMandel width height mx =
      foldr1 (\x acc -> x++"\n"++acc) $
           map calcRow $ ranger (-1) 1 height
           where calcRow y = map (calcCell y) $ ranger (-2) 1 width
                 calcCell y x = if mandelTest (x,y) mx
                                then '*'
                                else '-'

--mandel :: Double -> Double -> Int -> String
--mandel = foldr1 (\x acc -> x++"\n"++acc) calcMandel

--[ (x,y) | x <- ranger (-2) 1 70, y <- ranger (-1) 1 30]

main = do
     args <- getArgs
     let (w:h:mx:_) = args
         w' = read w::Double
         h' = read h::Double
         mx' = read mx::Int
         in do
          putStrLn $ show args
          let output = calcMandel w' h' mx' in --70 30 1000
                    putStrLn $ output