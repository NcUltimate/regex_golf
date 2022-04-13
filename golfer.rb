class Golfer
  class << self
    #########################
    # Main golfing algorithm.
    #########################
    def golf!(list1, list2)
      regexes = []

      # Build regex list
      list1.each do |word|
        regex_str = regexify(word)
        parts     = subparts(regex_str)
        dotified  = dotify(parts)

        regexes   += dotified
      end

      # Filter list to regexes that only
      #   match the first list
      regexes.uniq!.reject! do |regex|
        list2.any? { |str| str =~ /#{regex}/ }
      end

      # Remove duplicates
      regexes.uniq!

      # Then, greedily find the fewest regexes to build the list.
      # We want to find the regex that matches the most
      # remaining words on each iteration.
      solution = []
      until list1.length == 0
        regex = regexes.max_by do |reg|
          matches = list1.grep(/#{reg}/).count
          if matches == 0
            - 9999
          else
            matches + 5 - reg.length
          end
        end
        grep  = list1.grep(/#{regex}/)
        break if grep.count == 0

        list1 -= grep
        solution << regex
        regexes -= [regex]
      end

      solution.join('|')
    end

    #############################
    # Subparts for a given string
    #############################
    def subparts(regex_str)
      parts     = []
      cons_size = [regex_str.length, 5].min
      cons_size.times do |k|
        parts += regex_str.split(//).each_cons(k+1).map(&:join)
      end

      parts.uniq
    end

    ###########################################
    # Converts parts into combinations of dots
    ###########################################
    def dotify(parts)
      regexes = []

      parts.each do |part|
        part.length.times do |combo_size|
          start = part =~ /\^/ ? 1 : 0
          fin   = part =~ /\$/ ? part.length-1 : part.length
          combinations = (start..fin-1).to_a.combination(combo_size)

          combinations.each do |combo|
            newpart = part.dup

            combo.each { |idx| newpart[idx] = '.' }
            regexes << newpart
          end
        end
      end

      regexes
    end

    def regexify(str)
      "^#{str}$"
    end
  end
end