provides "load_average"
load_average Mash.new

raw_load_averages = %x[uptime|cut -d: -f4].strip.split(" ")

load_average[:one_minute] = raw_load_averages[0]
load_average[:five_minutes] = raw_load_averages[1]
load_average[:fifteen_minutes] = raw_load_averages[2]