puts "enter the attacker's UPP"
statAtt = gets
statAtt = statAtt.to_i

puts "enter the UPP for the one getting attacked or whatever"
statVic = gets
statVic = statVic.to_i

puts "enter the weapon. Type 'What?' for a list of weapons"
theWeapon = gets
puts theWeapon
if(theWeapon == "What?")
  puts "... put a list of weapons here later..."
end
# later check theWeapon against the list of weapons and prompt again if no match

puts "enter the range"
theRange = gets
theRange = theRange.to_i

#check for attacker DMs using the weapon
#'roll' for accuracy
#roll for damage
#roll to randomize UPP hit
#decrement UPP and output

#allow a continuous combat mode? Which keeps track of UPPs?
