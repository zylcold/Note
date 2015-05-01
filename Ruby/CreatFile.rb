puts "获取时间"
time1 = Time.new
time1Str = time1.strftime("%m-%d")
time2 = time1 - 24 * 60 * 60
time2Str = time2.strftime("%m-%d")
list = %x[ls ~/Desktop]
puts "扫描桌面文件夹"
list.split(/\n/).each do |fileName|
  $isExistOld = true if fileName == time2Str 
  $isExistNew = true if fileName == time1Str
end
if !$isExistOld
  puts "未发现昨日的文件夹，请手动创建"
elsif
  if !$isExistNew
    puts "创建当日的文件夹"
    %x[mkdir ~/Desktop/#{time1Str}]
    puts "正在拷贝文件中"
    %x[cp -R ~/Desktop/#{time2Str}/KKJY ~/Desktop/#{time1Str}/KKJY]
    ARGV.each do |fileName|
      %x[cp -R ~/Desktop/#{time2Str}/#{fileName} ~/Desktop/#{time1Str}/#{fileName}]
    end
    puts "拷贝完成"
  elsif
    puts "已存在此文件件夹\n尝试拷贝其他文件"
    ARGV.each do |fileName|
      %x[cp -R ~/Desktop/#{time2Str}/#{fileName} ~/Desktop/#{time1Str}/#{fileName}]
    end
  end
end