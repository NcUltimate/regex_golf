
lines = File.open('words.txt', 'r', &:readlines)

File.open('3LW', 'w') do |f|
  lines.each do |line|
    f.puts line if line.chomp.length == 3
  end
end