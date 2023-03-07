#!/usr/bin/env ruby

require 'net/ping'
# u subcomando opciones

file_data = File.read("./hosts").split
# ["host1", "host22", "user3"]

if ARGV[0] == p
    file_data.each do |host|
        pingable = Net::Ping::External.new(host)
        if pingable.ping?
            v = "FUNCIONA"
        else
            v = "falla"
        end
        puts "Maquina  #{host}  : #{v}"

    end
end


