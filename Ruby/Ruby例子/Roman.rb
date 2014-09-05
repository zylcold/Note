class Roman
  def self.method_missing name , *args
    roman = name.to_s
    roman.gsub!("IV", "IIII")
    roman.gsub!("IX", "VIIII")
    roman.gsub!("XL", "XXXX")
    roman.gsub!("XC", "LXXXX")
    
    (roman.count("I")+roman.count("V")*5+roman.count("X")*10
    +roman.count("L")*50+roman.count("C")*100)
  end
  
  def number_for name
    name1 = name
    if name1 == "X"
      name1 = "10"
    end
    
end

puts Roman.X
puts Roman.XC
puts Roman.XII
puts Roman.XL
puts Roman.XII
puts Roman.IV
puts Roman.number_for("X")