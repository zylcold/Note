class ActsAsCsv
  def read
    file = File.new(self.class.to_s.downcase + '.txt') #downcase --> Returns a copy of str with all uppercase letters replaced with their lowercase counterparts.                                                                             返回一个小写字母的字符串副本
    @headers = file.gets.chomp.split(', ') 
    
    file.each do |row|
      @result << row.chomp.split(', ')
    end
  end
  
  def headers 
    @headers
  end
  
  def csv_contents
    @result
  end
  
  def initialize
    @result = []
    read
  end
  
end

class RubyCsv < ActsAsCsv
end

m = RubyCsv.new

puts m.headers.inspect  # inspect --> Return a string describing this IO object  返回一个字符串对对象
puts m.csv_contents.inspect