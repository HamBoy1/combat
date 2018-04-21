keepGoing = true
opponents = Array.new
runs = 1

while keepGoing do
  puts "enter the name of opponent #{runs}"
  opponents << gets.chomp
  puts "keep going?"
  hold = gets.upcase.chomp
  runs = runs + 1
  if hold == "NO"
    keepGoing = false
  end
end



options = ['A','B','C','D','E','F','1','2','3','4','5','6','7','8','9']
def hexCheck(upp, extras)
  if extras.length != 0
    return false
  elsif (upp.length) != 6
    return false
  else
    return true
  end
end


oppsUpps = Array.new
notDone = false
loop do
  for name in opponents
    puts "enter upp for #{name}"
    hold = gets.upcase
    upp = hold.split(//)
    upp.pop
    extras = (upp - options)
    if hexCheck(upp, extras)
      oppsUpps << upp
      notDone = false
    else
      puts "invalid upp"
      notDone = true
      oppsUpps.clear
      break
    end
  end
  break if notDone == false
end

# flips = ['A','B','C','D','E','F']
# def changeChange(upp, flips)
#   space = 0
#   for val in upp
#     if val == "A" or val == "B" or val == "C" or val == "D" or val == "E" or val == "F"
#       upp[space] = flips.index(val) + 10
#     end
#     space = space +1
#   end
# end
#
# changeChange(upp, flips) #changes any letters to numbers

print oppsUpps
