# ================================
publish =	false
date	=	""	
slug	=	""
jkname	= 	""
dirray  =   []
# ================================


# -----------------------------------
# CLASS DEFINITION
# -----------------------------------



# -----------------------------------
# READ CONFIG FILE
# -----------------------------------

configfile = ARGV.first
config = File.read(configfile)
config.split("\n").each do |line|
	k,v=line.split(":")
	# puts k, v
	if k =~ /dir/
		# .strip removes any extra space from the dir path
		dirray.push(v.strip)
	end
end
# puts dirray

# -----------------------------------
# LOOP THROUGH THE DIRECTORIES
# -----------------------------------
caz=''
wdir=''
dirray.each do |wdir|
	puts '--------------------------------'
	puts wdir
	Dir.glob(wdir+"/*.md").each do |draft|
		puts draft
	end
end

exit


filename = ARGV.first
# puts "Here's your file #{filename}:"
text = File.read(filename)
# puts text
splitext = text.split("---")
head = splitext[1]
# puts head

head.split("\n").each do |line|
	k,v=line.split(":")
# ---------------------------------
	if k =~ /published/ and v =~ /yes/
		publish=true
	end
# ---------------------------------
	if k =~ /date/
		date=v
		d,m,y = v.split('-')
		day   = '%02d' % d
		month = '%02d' % m
		year  = '%04d' % y
		date=year + "-" + month + "-" + day
	end
# ---------------------------------
	if k =~ /slug/
		slug=v.strip
	end
end

if publish == true 
	if date == false
		puts filename + " ER date is missing"
	end
	if slug == ""
		puts filename + " ER slug is missing"
	end
end

if publish==true and date!="" and slug!=""
	jkname = date + "-" + slug + ".md"
	puts filename + " || post READY, moving it to the queue directory"
	puts jkname
else
	puts filename + " || post not ready"
end