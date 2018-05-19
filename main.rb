keepGoing = true
opponents = Array.new
runs = 1

#gets the names of everyone involved in combat
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

#checks that the upp is the right length and characters
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

#gets upps for all fighters
oppsUpps = Array.new
notDone = false
puts ""
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

#changes letters in upp to numbers
flips = ['A','B','C','D','E','F']
def changeChange (oppsUpps, flips)
  oppsUpps.each do |sub_array|
  space = 0
  for item in sub_array
    if item == "A" or item == "B" or item == "C" or item == "D" or item == "E" or item == "F"
      sub_array[space] = flips.index(item) + 10
    end
    space += 1
    end
  end
end

changeChange(oppsUpps, flips)

#########################################################
#arrays of weapons and dm check values
weaponOptions = ['HANDS','CLAWS','TEETH','HORNS','HOOVES','STINGER','THRASHER','CLUB','DAGGER','BLADE','FOIL','CUTLASS','SWORD','BROADSWORD','BAYONET','SPEAR','HALBERD','PIKE','CUDGEL']
requiredCheck = [6,0,0,0,0,0,0,5,4,5,5,7,6,8,5,5,6,7,5]
advantageousCheck = [9,0,0,0,0,0,0,8,8,9,10,11,10,12,9,8,10,10,8]
advantageousBlow = [1,0,0,0,0,0,0,2,2,1,1,2,1,2,2,2,2,2,2]
weakenedBlow = [2,0,0,0,0,0,0,1,2,2,2,4,3,4,2,3,3,3,1]
weaponDamageRoll = [1,2,2,2,2,3,2,2,2,2,1,3,2,4,3,2,3,3,2]

#gets the fighters for one combat round
fighters = Array.new
puts ""
puts "who's attacking who? (format as [name] attacks [name])"
fighters = gets.chomp
fighters = fighters.split(" attacks ")

attacker = opponents.index(fighters[0])
victim = opponents.index(fighters[1])

#gets the weapon for the attacker
allGood = false
until allGood == true do
  puts "what weapon is #{fighters[0]} using? (enter 'help' for a list of weapons)"
  weapon = gets.chomp.upcase

  if weapon == "HELP"
    puts weaponOptions
    allGood = false
  elsif !weaponOptions.include?(weapon)
    puts "invalid weapon"
    allGood = false
  else
    puts "valid weapon"
    allGood = true
  end
end

#checks for strength dms by weapon
strength = oppsUpps[attacker][0]
spot = weaponOptions.index(weapon)
blowDM = 0

if (strength.to_i >= advantageousCheck.fetch(spot))
  blowDM = advantageousBlow.fetch(spot)
  puts "strength advantage of +#{blowDM} to blow"
elsif (strength.to_i < requiredCheck.fetch(spot))
  blowDM = 0 - weakenedBlow.fetch(spot)
  puts "not strong enough. Deal a weakened blow with DM of #{blowDM}"
else
  puts "okie dokie"
end

#########################################################
#armor stuff#
#########################################################
#doing things#


#roll for accuracy
accuracy = 1 + rand(20)
if accuracy == 20
  puts "rolled a 20 on accuracy check. Yeehaw."
elsif accuracy >= 8
  puts "rolled #{accuracy} on accuracy check. Hit."
else
  puts "rolled #{accuracy} on accuracy check. Miss."
end

def damageCheck(weapon, weaponOptions, weaponDamageRoll, oppsUpps, victim, blowDM)
  numDice = weaponDamageRoll[weaponOptions.index(weapon)]
  baseDamage = 0
  numDice.times do
    baseDamage = baseDamage + (1+rand(6))
  end

  totalDamage = baseDamage + blowDM #+ gunDM - armor

  puts oppsUpps[victim][rand(2)].to_i #- totalDamage
end

damageCheck(weapon, weaponOptions, weaponDamageRoll, oppsUpps, victim, blowDM)
