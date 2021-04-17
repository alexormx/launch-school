# @param {Integer[]} arr
# @param {Integer[][]} pieces
# @return {Boolean}
def can_form_array(arr, pieces)
  lenght_arr = 0
  index = 0
  found = false
  while pieces.size > 0
    found = false if index == 0
    if pieces[index] == arr[lenght_arr, pieces[index].size]
      lenght_arr += pieces[index].size
      found = true
      pieces.delete_at(index)
      index = 0
      next
    else
      index +=1
    end
    return false if !found && index == (pieces.size )      
  end
  true
end

p can_form_array([85], [[85]]) == true
p can_form_array([15,88], [[88],[15]]) == true
p can_form_array([49,18,16],[[16,18,49]]) == false
p can_form_array([91,4,64,78],[[78],[4,64],[91]]) == true
p can_form_array([1,3,5,7], [[2,4,6,8]]) == false
#p can_form_array([2,82,79,95,28],[[2],[82],[28],[79,95]])
#p can_form_array([49,18,16],[[16,18,49]])