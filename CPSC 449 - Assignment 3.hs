-- Patrick Quan
-- 10152770
-- CPSC 449 Assignment 3


-- Question 1
data Season = Fall | Winter | Spring | Summer
  deriving(Eq)
data Month = January | February | March | April | May | June | July | August | September | October | November | December
  deriving(Eq, Show)
  
months :: Season -> (Month, Month, Month)
months x
  |x == Fall = (October, November, December)
  |x == Winter = (January, February, March)
  |x == Spring = (April, May, June)
  |x == Summer = (July, August, September)
  
  
-- Question 2
data Form = And Form Form | Or Form Form | Not Form | Val Bool
  deriving(Eq)

eval :: Form -> Bool
eval (Val True) = True
eval (Val False) = False
eval (And x y)
  |eval x == True && eval y == True = True
  |otherwise = False
eval (Or x y)
  |eval x == True && eval y == False = True
  |eval x == False && eval y == True = True
  |eval x == True && eval y == True = True
  |otherwise= False
eval (Not x)
  |eval x == False = True
  |otherwise = False

-- Question 3
data NTree = Leaf Int | Node NTree Int NTree

collapse :: NTree -> [Int]
collapse (Leaf n) = [n]
collapse (Node left n right) = (collapse left) ++ [n] ++ (collapse right)

-- Question 4
data PTree a = PLeaf | PNode a (PTree a) (PTree a)
  deriving (Show)
  
countLeaves :: PTree a -> Integer
countLeaves PLeaf = 2
countLeaves (PNode a left right) = 1 + max (countLeaves left) (countLeaves right)

-- Question 5
data Store = Empty | Join Int Store Store

maxStore :: Store -> Int
maxStore Empty = 0
maxStore (Join n left right)
  |n >= max (maxStore left) (maxStore right) = n
  |otherwise = max (maxStore left) (maxStore right)


-- Question 6
data Expr = Num Integer | BinOp Op Expr Expr 
  deriving (Eq, Show)
data Op = Add | Mul
  deriving (Eq, Show)
  
countOp :: Op -> Expr -> Int 
countOp Add (BinOp n x y)
  |n == Add = 1 + (countOp Add x) + (countOp Add y)
  |otherwise = (countOp Add x) + (countOp Add y)
countOp Mul (BinOp n x y)
  |n == Mul = 1 + (countOp Mul x) + (countOp Mul y)
  |otherwise = (countOp Mul x) + (countOp Mul y)
countOp _ (Num x) = 0

-- Question 7
data Tree a = Nil | Value a (Tree a) (Tree a)
  deriving (Show)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree x Nil = Nil
mapTree x (Value n left right) = Value(x n) (mapTree x left) (mapTree x right)

countChars :: String -> Integer
countChars x = toInteger (length x) 

-- Question 8 FIX
foldTree :: (a -> a -> a) -> a -> Tree a -> a
foldTree x y Nil = y
foldTree x y (Value n left right) = x n (foldTree x y left)

-- Question 9
data Road = City String | Fork Road Road
  deriving (Show, Eq)
  
reachable :: String -> Road -> Bool
reachable x (City y)
  |x == y = True
  |otherwise = False
reachable x (Fork y z)
  |(reachable x y) == True = True
  |(reachable x z) == True = True
  |otherwise = False

-- Question 10
data LR = L | R

insertRoad :: (Road, LR) -> String -> Road -> Road
insertRoad (x, L) y (Fork m n)
  |m == (City y) = (Fork x (Fork m n))
  |n == (City y) = (Fork m (Fork x n))
  |otherwise = (Fork m (insertRoad (x, L) y n))
insertRoad (x, R) y (Fork m n)
  |m == (City y) = (Fork m (Fork x n))
  |n == (City y) = (Fork m (Fork n x))
  |otherwise = (Fork m (insertRoad (x, R) y n))