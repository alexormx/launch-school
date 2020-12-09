# P -- Analyze de Problem
# Create a program that with a given row number returns the sum of all the elements, the rows are consecutive rows with even numbers starting from 2
# Each row has the quantity of numbers according to its position.
# Input -- Row Number (Integer)
# Output -- Sum of elements in row number (Integer)
# rules: 
# 	Explecit requirments
# 			- Each row has consecutive even numbers (+2)
# 			- The quantity of numbers in row is according to the row number ex. Row 1 --> 1 number, Row 2--> 2 numbers, etc...
# 			- The result should be the sum of the row requiered in the input
#  	Implecit requirments
#			- The first row will be always the number 2. 
#			- The input number of row has to be greater than 0.
# E -- Examples // Test Cases
# even_row_sum(0) --> 0 []
# even_row_sum(1) --> 2 [2]
# even_row_sum(2) --> 10 [4, 6]
# even_row_sum(3) --> 30 [8, 10, 12]
# even_row_sum(4) --> 68 [14, 16, 18, 20]
# even_row_sum(5) --> 130 [22, 24, 26, 28, 30]
# D -- Data Structure
# Data strucutre to be used to save the sum will be an array that returns the position of the row
# a current number that will continue increase by 2
# a current row that will be keeping the numbers
# A -- Algorithm
# ***funtion to generate the rows***
# start create row(row_number)
# define the empty array
# define the sum equal to 0
# loop the rows quantity
# push sum to array
# define sum to 0
# loop the from 0 to row quantity (1- 1, 2-2)
# sum plus current
# end loops
# return array[-1]
#ends

# C -- Code
def even_row_sum(row)
  arr= []
  sum = [] 
  current = 2
  (1..row).each do |x|
    (1..x).each do |y|
      sum << current
      current += 2
    end
    arr.push(sum)
    sum = []
  end
  return arr[-1].sum
end

p even_row_sum(1) == 2
p even_row_sum(2) == 10
p even_row_sum(3) == 30
p even_row_sum(4) == 68
p even_row_sum(5) == 130
p even_row_sum(6) == 222
p even_row_sum(7) == 350