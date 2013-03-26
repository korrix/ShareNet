#!/usr/bin/env ruby
require "colorize"

trap("INT") do
  error("Caught signal 2:  Attempting to exit gracefully...")
  `killall dhcpd`
  `killall hostapd`
  `killall wvdial`
  `killall pppd`
  `iptables -t nat -D POSTROUTING -j MASQUERADE -o ppp0`
  ok("Everyone were killed. Exitting")
  exit(0)
end


class String
  def bold
     "\033[1m#{self}\033[22m"
  end
end

def info(text)
  puts "[INFO] #{text}".bold.blue
end

def ok(text)
  puts "[OK] #{text}".bold.green
end

def error(text)
  puts "[ERROR] #{text}".bold.red
end

# Here is the script
info("The ShareNet is starting now")
info("Starting wvdial")
wvdial = IO.popen("wvdial aero2 -C wvdial.conf 2>&1")

print("Connecting".bold.green)
wvdial.each do |line|
  print ".".bold.green
  if line =~ /local  IP address (.+)$/
    print "\n"
    ok("Connected. Local ip: #{$1}")
    break
  end   
end

info("Starting hostapd")
hostapd = IO.popen("hostapd hostapd.conf -d 2>&1")
sleep(0.5)

info("Setting proper IP on wlan0")
`ifconfig wlan0 192.168.0.1/24 up`
sleep(1)

info("Starting isc-dhcp-server")
dhcpd = IO.popen("dhcpd -cf dhcpd.conf -d 2>&1")

info("Enabling IPv4 forwarding in kernel")
`sysctl net.ipv4.ip_forward=1`

info("Adding iptables rule")
`iptables -t nat -A POSTROUTING -j MASQUERADE -o ppp0`

puts ""
dhcpd.each do |i|
  if i =~ /DHCPACK on (.+) to (.+) \((.+)\) via wlan0/
    puts "#{$2.bold.yellow} (#{$3.bold.cyan}) -> #{$1.bold.white}"
  end
end
