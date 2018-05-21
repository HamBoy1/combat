keepGoing = true
opponents = Array.new
runs = 1

#gets the names of everyone involved in combat
while keepGoing do
  puts "enter the name of opponent #{runs}"
  opponents << gets.chomp
  puts "add another opponent?"
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
    puts""
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
#armor stuff#
puts ""
armorOptions = ["NOTHING","JACK","MESH","CLOTH","REFLEC","ABLAT","COMBAT ARMOR"]
armorDMS = [[1,3,2,2,3,4,7,0,0,1,2,4,3,5,2,1,4,1,0,0,1,1,2,3,6,5,5,2,3], #nothing
            [-1,0,1,1,3,3,7,0,-1,0,0,3,3,5,1,0,3,0,0,0,1,1,2,3,6,5,5,2,3], #jack
            [-4,0,1,0,2,0,4,-2,-4,-4,-4,-2,-3,1,0,-2,-2,-2,-2,-2,-1,-1,0,0,2,-1,0,1,2], #mesh
            [-4,1,0,-1,2,1,4,-3,-4,-4,-3,-3,-3,0,-1,-2,-3,-2,-3,-4,-3,-3,-3,-3,-1,-3,-3,1,2], #cloth
            [0,-1,-2,2,3,2,7,0,0,1,2,4,3,5,2,-1,4,-1,0,-4,1,1,2,2,6,5,5,-8,-8], #reflec
            [-1,-3,-4,-2,2,0,4,-2,-2,-3,-2,-2,-2,1,-2,-3,-2,-3,-2,-2,-1,-1,-1,1,3,2,2,-7,-7], #ablat
            [-6,-7,-7,-5,-6,-6,0,-7,-7,-5,-8,-6,-6,-4,-6,-6,-5,-6,-7,-7,-5,-5,-5,-5,-3,-5,-4,-6,-6]] #combat

playerArmor = Array.new

for name in opponents
  allGood = false
  until allGood == true do
    puts ""
    puts "what armor is #{name} wearing? (enter 'help' for a list of armor)"
    armor = gets.chomp.upcase

    if armor == "HELP"
      puts armorOptions
      allGood = false
    elsif !armorOptions.include?(armor)
      puts "invalid armor"
      allGood = false
    else
      puts "valid armor"
      allGood = true
    end
  end
  playerArmor << armor
end

#########################################################
#arrays of weapons and dm check values
weaponOptions = ['HANDS','CLAWS','TEETH','HORNS','HOOVES','STINGER','THRASHER','CLUB','DAGGER','BLADE','FOIL','CUTLASS','SWORD','BROADSWORD','BAYONET','SPEAR','HALBERD','PIKE','CUDGEL']
requiredCheck = [6,0,0,0,0,0,0,5,4,5,5,7,6,8,5,5,6,7,5]
advantageousCheck = [9,0,0,0,0,0,0,8,8,9,10,11,10,12,9,8,10,10,8]
advantageousBlow = [1,0,0,0,0,0,0,2,2,1,1,2,1,2,2,2,2,2,2]
tooLowBlow = [2,0,0,0,0,0,0,4,2,2,1,2,2,4,2,1,2,3,1]
weakenedBlow = [2,0,0,0,0,0,0,1,2,2,2,4,3,4,2,3,3,3,1]
weaponDamageRoll = [1,2,2,2,2,3,2,2,2,2,1,3,2,4,3,2,3,3,2]

gunOptions = ['BODY PISTOL','AUTOMATIC PISTOL','REVOLVER','CARBINE','RIFLE','AUTOMATIC RIFLE','SHOTGUN','SUBMACHINEGUN','LASER CARBINE','LASER RIFLE']
gunRequiredCheck = [8,7,7,5,6,7,4,6,6,7]
gunAdvantageousCheck = [11,10,9,9,8,10,9,9,10,11]
gunTooLowShot = [3,2,2,1,2,2,1,2,3]
gunAdvantageousShot = [1,1,1,1,1,2,1,2,2]
gunDamageRoll = [3,3,3,3,3,3,4,3,4,5]


###
#gets the fighters for one combat round

def getFighters(opponents)
  $fighters = Array.new
  puts ""
  puts "who's attacking who? (format as [name] attacks [name])"
  $fighters = gets.chomp
  $fighters = $fighters.split(" attacks ")


  @attacker = opponents.index($fighters[0])
  @victim = opponents.index($fighters[1])
end

#gets the weapon for the attacker
def getWeapon(weaponOptions, gunOptions)
  allGood = false
  until allGood == true do
    puts "what weapon is #{$fighters[0]} using? (enter 'help' for a list of weapons)"
    @weapon = gets.chomp.upcase

    if @weapon == "HELP"
      puts weaponOptions
      puts ""
      puts gunOptions
      allGood = false
    elsif !weaponOptions.include?(@weapon) && !gunOptions.include?(@weapon)
      puts "invalid weapon"
      puts ""
      allGood = false
    else
      puts "valid weapon"
      puts ""
      allGood = true
    end
  end
end

#checks for blow dms by strength

######################################################################################################HEY! WHAT YOU
#NEED TO DO NOW IS MAKE IT CHECK ONLY GUN /OR/ WEAPON BUT NOT BOTH OR IT RETURNS NIL

#checks for shot dms by dexterity
def bonusCheck(weaponOptions, oppsUpps, advantageousCheck, advantageousBlow, requiredCheck, tooLowBlow, weakenedBlow, gunOptions, gunAdvantageousCheck, gunAdvantageousShot, gunRequiredCheck, gunTooLowShot)
  @blowDM = 0
  @shotDM = 0
  if weaponOptions.include?(@weapon)
    strength = oppsUpps[@attacker][0]
    spot = weaponOptions.index(@weapon)
    if (@endurance.to_i >= 0)
      if (strength.to_i >= advantageousCheck.fetch(spot))
        @blowDM = advantageousBlow.fetch(spot)
        puts "strength advantage of +#{@blowDM} to blow"
      elsif (strength.to_i < requiredCheck.fetch(spot))
        @blowDM = 0 - tooLowBlow.fetch(spot)
        puts "not strong enough. Deal a weakened blow with DM of #{@blowDM}"
      else
        puts "okie dokie"
      end
    else
      @blowDM = 0 - weakenedBlow.fetch(spot)
    end
  else
    dexterity = oppsUpps[@attacker][1]
    spot = gunOptions.index(@weapon)
    if (dexterity.to_i >= gunAdvantageousCheck.fetch(spot))
      @shotDM = gunAdvantageousShot.fetch(spot)
      puts "dexterity advantage of +#{@shotDM} to blow"
    elsif (dexterity.to_i < gunRequiredCheck.fetch(spot))
      @shotDM = 0 - gunTooLowShot.fetch(spot)
      puts "not dextrous enough. Deal a weakened blow with DM of #{@shotDM}"
    end
  end
end

#########################################################
#doing things#

#gets dm based on armor
def armorAdvan(playerArmor, armorOptions, weaponOptions, gunOptions, armorDMS)
  armor = playerArmor[@victim]
  armorSpot = armorOptions.index(armor)
  if weaponOptions.include?(@weapon)
    weaponSpot = weaponOptions.index(@weapon)
  else
    weaponSpot = gunOptions.index(@weapon)
  end
  @defenseDM = armorDMS[armorSpot][weaponSpot]
end


def damageCheck(weaponOptions, gunOptions, weaponDamageRoll, gunDamageRoll, oppsUpps, opponents)
  if weaponOptions.include?(@weapon)
    numDice = weaponDamageRoll[weaponOptions.index(@weapon)]
  else
    numDice = gunDamageRoll[gunOptions.index(@weapon)]
  end

  baseDamage = 0
  numDice.times do
    baseDamage = baseDamage + (1+rand(6))
  end

  totalDamage = baseDamage + @blowDM + @shotDM + @defenseDM

  puts "blowDM = #{@blowDM}"
  puts "shotDM = #{@shotDM}"
  puts "defenseDM = #{@defenseDM}"
  puts "rolled damage = #{baseDamage}"
  puts "total damage = #{totalDamage}"

  trait = rand(2)
  oppsUpps[@victim][trait] = oppsUpps[@victim][trait].to_i - totalDamage
  puts "#{opponents[@victim]}'s upp now = #{oppsUpps[@victim]}'"
end

#roll for accuracy
def accuracyCheck(weaponOptions, gunOptions, weaponDamageRoll, gunDamageRoll, oppsUpps, opponents)
  accuracy = 1 + rand(20)
  if accuracy == 20
    puts "rolled a 20 on accuracy check. Yeehaw."
    damageCheck(weaponOptions, gunOptions, weaponDamageRoll, gunDamageRoll, oppsUpps, opponents)
  elsif accuracy >= 8
    puts "rolled #{accuracy} on accuracy check. Hit."
    damageCheck(weaponOptions, gunOptions, weaponDamageRoll, gunDamageRoll, oppsUpps, opponents)
  else
    puts "rolled #{accuracy} on accuracy check. Miss."
  end
end

loop do
  puts ""
  puts "begin combat round?"
  roundAnswer = gets.chomp.upcase
  if roundAnswer == "YES"
    getFighters(opponents)
    @endurance = oppsUpps[@attacker][1]
    getWeapon(weaponOptions, gunOptions)
    bonusCheck(weaponOptions, oppsUpps, advantageousCheck, advantageousBlow, requiredCheck, tooLowBlow, weakenedBlow, gunOptions, gunAdvantageousCheck, gunAdvantageousShot, gunRequiredCheck, gunTooLowShot)
    armorAdvan(playerArmor, armorOptions, weaponOptions, gunOptions, armorDMS)
    accuracyCheck(weaponOptions, gunOptions, weaponDamageRoll, gunDamageRoll, oppsUpps, opponents)
  else
    puts "ending combat"
    break
  end
end
