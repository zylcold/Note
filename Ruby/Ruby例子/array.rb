a = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
i = a.count
c = 0

until c == i do 
  if c == 3 || c == 7 || c == 11 then
    puts a[c]
  else
    print"#{a[c]}"
    if c != 15 then
      print ","
    end
  end
  c += 1;
end