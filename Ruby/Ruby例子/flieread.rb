f = File.new("zhu.txt",'r')
puts f.readline
f.close
f = File.new("zhu.txt",'r')
f.each{|a| puts a}
f.close