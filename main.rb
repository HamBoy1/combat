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


################################################################################

puts "enter the weapon"
weapon = gets.upcase
weapon = weapon.chomp

weaponOptions = ['HANDS','CLAWS','TEETH','HORNS','HOOVES','STINGER','THRASHER','CLUB','DAGGER','BLADE','FOIL','CUTLASS','SWORD','BROADSWORD','BAYONET','SPEAR','HALBERD','PIKE','CUDGEL']
requiredCheck = [6,0,0,0,0,0,0,5,4,5,5,7,6,8,5,5,6,7,5]
advantageousCheck = [9,0,0,0,0,0,0,8,8,9,10,11,10,12,9,8,10,10,8]
advantageousBlow = [1,0,0,0,0,0,0,2,2,1,1,2,1,2,2,2,2,2,2]
weakenedBlow = [2,0,0,0,0,0,0,1,2,2,2,4,3,4,2,3,3,3,1]


if  !weaponOptions.include?(weapon)
  puts "invalid weapon"
else
  puts "valid weapon"
end


puts "enter strength"
strength = gets

spot = weaponOptions.index(weapon)
blowDM = 0

if (strength.to_i >= advantageousCheck.fetch(spot))
  puts "extra strong ;)"
  blowDM = advantageousBlow.fetch(spot)
elsif (strength.to_i < requiredCheck.fetch(spot))
  puts "too low... :("
  blowDM = 0 - weakenedBlow.fetch(spot)
else
  puts "okie dokie"
end

puts blowDM
