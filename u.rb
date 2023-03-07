#!/usr/bin/env ruby

require 'net/ping'
require 'net/ssh'
# u subcomando opciones

file_data = File.read("./hosts").split
# ["host1", "host22", "user3"]

if ARGV[0] == 'p'
    file_data.each do |host|
        pingable = Net::Ping::External.new(host)
        if pingable.ping?
            v = "FUNCIONA"
        else
            v = "falla"
        end
        puts "Maquina  #{host}  : #{v}"

    end
elsif ARGV[0] == 's'
    file_data.each do |host|
            Net::SSH.start(host, "a795809") do |ssh|
            result = ssh.exec!("ls -l")

            if result != null
                v = "FUNCIONA"
            else
                v = "falla"
            end
            puts "Maquina  #{host}  : #{v}"
            puts result
        end
    end
end
