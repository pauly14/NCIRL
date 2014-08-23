

require 'net/smtp'

smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
emailServer = "smtp.gmail.com"
serverPort = 25
passWord="Romulus3366"
userName= "pauly.harrison01@gmail.com"
domain="gmail.com"
fm= "pauly.harrison01@gmail.com.com "
to = ARGV[0]
sendMsg = <<END_OF_MESSAGE
From: pauly.harrison01@gmail.com.com
To: #{ARGV[0]}
Subject: #{ARGV[1]}
 
#{ARGV[2]}
END_OF_MESSAGE
 
 
 
begin
smtp = Net::SMTP.new('smtp.gmail.com', 587 )
smtp.enable_starttls
smtp.start(domain, userName, passWord, :login) do |smtp|
smtp.send_message sendMsg, fm, to
 
end
 
end