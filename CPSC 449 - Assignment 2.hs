-- Patrick Quan
-- 10152770
-- CPSC 449 Assignment 2

import Data.Char
import Data.List

-- Question 1
productFactorial :: Integer -> Integer
productFactorial x = factorial(x) 

factorial :: Integer -> Integer
factorial 0 = 1
factorial x = x * factorial(x - 1)


-- Question 2
smallestFactor :: Integer -> Integer
smallestFactor 0 = 0
smallestFactor 1 = 1
smallestFactor x = smallestFactorRec x (2)

smallestFactorRec :: Integer -> Integer -> Integer
smallestFactorRec x y 
  | x `rem` y == 0 = y
  | x `rem` y > 0 = smallestFactorRec x (y + 1)


-- Question 3
gameOddEven :: Integer -> [Integer]
gameOddEven 1 = [1]
gameOddEven x 
  | x `rem` 2 == 0 = x : gameOddEven(x `div` 2)
  | otherwise = x : gameOddEven y
  where y = ((x * 3) + 1)


-- Question 4
isGoodPassword :: String -> Bool
isGoodPassword x
  | length x < 7 = False
  | not (hasLetter x) = False
  | not (hasNum x) = False
  | not (upCase x) = False
  | not (lowCase x) = False
  | otherwise = True

hasLetter :: String -> Bool
hasLetter [] = False
hasLetter (x:xs)
  | isLetter x = True
  | otherwise = hasLetter xs

hasNum :: String -> Bool
hasNum [] = False
hasNum (x:xs)
  | isNumber x = True
  | otherwise = hasNum xs

upCase :: String -> Bool
upCase [] = False
upCase (x:xs)
  | isUpper x = True
  | otherwise = upCase xs
  
lowCase :: String -> Bool
lowCase [] = False
lowCase (x:xs)
  | isLower x = True
  | otherwise = lowCase xs


-- Question 5
isPrime :: Integer -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime x = not (primeRec x (x-1))

primeRec :: Integer -> Integer -> Bool
primeRec x 2 = x `rem` 2 == 0
primeRec x y = x `rem` y == 0 || primeRec x (y-1)


-- Question 6 
allDivisors :: Integer -> [Integer]
allDivisors 0 = [0]
allDivisors 1 = [1]
allDivisors x = 1 : allDivisorsRec x 2

allDivisorsRec :: Integer -> Integer -> [Integer]
allDivisorsRec x y
  | x == y = [x]
  | x `rem` y == 0 = y : allDivisorsRec x (y + 1)
  | otherwise = allDivisorsRec x (y + 1)


-- Question 7
matches :: Integer -> [Integer] -> [Integer]
matches x [] = []
matches x (y:ys)
  | x == y = x : matches x ys
  | otherwise = matches x ys


-- Question 8
solveQuadraticEquation :: Double -> Double -> Double -> (Double, Double)
solveQuadraticEquation a b c = (x, y)
  where
    x = e + sqrt d / (2 * a)
    y = e - sqrt d / (2 * a)
    d = b * b - 4 * a * c
    e = (-b) / (2 * a)


-- Question 9
occursIn :: Integer -> [Integer] -> Bool
occursIn y [] = False
occursIn y(x:xs)
  |y == x = True
  |otherwise = occursIn y xs


-- Question 10
allOccurIn :: [Int] -> [Int] -> Bool
allOccurIn [] _ = True
allOccurIn _ [] = False
allOccurIn (x:xs) y = elem x y && allOccurIn xs y
  

-- Question 11
sameElements :: [Integer] -> [Integer] -> Bool
sameElements [] [] = True
sameElements x y
  | a == b = True
  | otherwise = False
  where
    a = sort x
    b = sort y


-- Question 12
numOccurrences :: Integer -> [Integer] -> Integer
numOccurrences x [] = 0
numOccurrences x (y:ys)
  | x == y = 1 + numOccurrences x ys
  | otherwise = numOccurrences x ys


-- Question 13
allUrls :: String -> [String]
allUrls [] = []
allUrls x = isUrl (words x)

isUrl :: [String] -> [String]
isUrl [] = []
isUrl (x:xs)
  | take 7 x == "http://" = x : isUrl xs
  | otherwise = isUrl xs


-- Question 15
pascal :: Int -> [Int]
pascal 0 = [1]
pascal x = zipWith (+) ([0] ++ pascal(x - 1)) (pascal (x - 1) ++ [0])