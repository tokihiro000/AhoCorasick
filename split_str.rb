require 'set'
def GetStrSet const_str
  str = const_str.dup
  set = Set.new
  length = str.length - 1
  while str.length > 0
    length = str.length
    length.times do |i|
      str.scan(/.{1,#{i + 1}}/).each do |s|
        set.add s
      end
    end
    str[0] = ''
  end

  return set
end

# set = GetStrSet "abcdefgh"
# set.each do |str|
#   puts str
# end
