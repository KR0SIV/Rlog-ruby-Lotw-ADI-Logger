#adi logger by KR0SIV

class Hamlog
	def initialize()
    #nothing here
    end


	def getutc
		time = Time.now.getutc.to_s
		time.gsub!(/-/, '').gsub!(/UTC/, '').gsub!(/:/, '')
		timearray = time.split(' ')
		$date = timearray[0]
		$utc  = timearray[1]
	end

	def write(qso, band, mode, freq)
		self.getutc
		count = "0"
		open('log.adi', 'a') do |f|
			f.puts "<CALL:#{count}>#{qso}"
			f.puts "    <BAND:3>#{band}"
			f.puts "    <MODE:5>#{mode}"
			f.puts "    <QSO_DATE:8>#{$date}"
			f.puts "    <TIME_ON:6>#{$utc}"
			f.puts "    <FREQ:6>#{freq}"
			f.puts "    <FREQ_RX:6>#{freq}"
			f.puts "<EOR>"
			puts ""
			puts "Added to log"
			puts ""
		end
		count = count.next
	end


end

log = Hamlog.new()

#log.getutc

loop do
	print "QSO With: "
	qso = gets.chomp.upcase

	print "Band: "
	band = gets.chomp

	print "Mode: "
	mode = gets.chomp

	print "Freq: "
	freq = gets.chomp

	log.write(qso, band, mode, freq)
end
#puts $utc
#puts $date