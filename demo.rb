require_relative 'golfer.rb'

sample_size = (ARGV[0] && ARGV[0].to_i) || 10
word_size   = (ARGV[1] && ARGV[1].to_i) || 4
filename    = "#{word_size}LW"

words = File.open(filename, 'r', &:readlines).map(&:chomp).shuffle

list1 = words[0 .. words.length / 2].sample(sample_size)
list2 = words[words.length / 2 .. -1].sample(sample_size)

list3 = list1.sort.zip(list2.sort)
puts
list3.each do |pair|
  puts pair.join('  ')
end

puts "----------------"
puts Golfer.golf!(list1, list2)
puts


