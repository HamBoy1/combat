puts "enter your UPP"
hold = gets.upcase
upp = hold.split(//)
upp.pop

options = ['A','B','C','D','E','F','1','2','3','4','5','6','7','8','9']
extras = (upp - options)
def hexCheck(upp, extras)
  if extras.length != 0
    puts "invalid UPP"
  elsif (upp.length) != 6
    puts "invalid UPP"
  else
    puts "valid UPP"
  end
end

flips = ['A','B','C','D','E','F']
def changeChange(upp, flips)
  space = 0
  for val in upp
    if val == "A" or val == "B" or val == "C" or val == "D" or val == "E" or val == "F"
      upp[space] = flips.index(val) + 10
    end
    space = space +1
  end
  print upp
end

hexCheck(upp, extras) #checks that upp is valid
changeChange(upp, flips) #changes any letters to numbers
