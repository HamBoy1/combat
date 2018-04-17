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
    puts "okay"
  end
end

hexCheck(upp, extras)
