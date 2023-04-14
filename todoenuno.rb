#!/usr/bin/env ruby
require 'optparse'

P1 = ["orouter8", "o8ff2"]
P2 = ["o8ff3", "o8ff4"]
P3 = ["o8nfs1", "o8ipa1", "o8ipa2", "o8cliente1", "o8cliente2", "o8router81"]

ROUTERS = ["orouter8", "o8router81"]
MAQP12 = ["o8ff2", "o8ff3", "o8ff4"]
MAQP3 = [ "o8router81","o8nfs1", "o8ipa1", "o8ipa2", "o8cliente1", "o8cliente2"]


ips = Hash["orouter8" => "2001:470:736b:f000::181",
           "o8ff2" => "2001:470:736b:820::2",
           "o8ff3" => "2001:470:736b:820::3",
           "o8ff4" => "2001:470:736b:820::4",
           "o8router81" => "2001:470:736b:811::1",
           "o8ipa1" => "2001:470:736b:811::2",
           "o8ipa2"  => "2001:470:736b:811::3",
           "o8nfs1" => "2001:470:736b:811::4",
           "o8cliente1" => "2001:470:736b:812:5054:ff:fe08:1205",
           "o8cliente2" => "2001:470:736b:812:5054:ff:fe08:1206"]

options = {}
optparse = OptionParser.new do|opts|
	opts.banner = "Uso: todoenuno.rb [options][nombreMaquina]"
	options[:back] = false #ok
	options[:back1] = false #ok
	options[:back2] = false #ok
	options[:back3] = false #ok
	options[:lista] = false #ok
	options[:conn] = nil #ok
	options[:xml] = false #ok
	options[:shut] = false #ok
	options[:on] = false #ok
	options[:router] = false #ok




	opts.on( '-o', '--on', 'Encenderá todas las máquinas
	-o -1 Se encenderán las máquinas de la practica 1
	-o -2 Se encenderán las máquinas de la practica 2
	-o -3 Se encenderán las máquinas de la practica 3' ) do
		options[:on] = true
	end

	opts.on( '-s', '--shutdown', 'Apagará todas las máquinas
	-s -1 Se apagarán las máquinas de la practica 1
	-s -2 Se apagarán las máquinas de la practica 2
	-s -3 Se apagarán las máquinas de la practica 3
	-s -r Se apagarán los routers' ) do
		options[:shut] = true
	end

	opts.on( '-r', '--router', 'Encenderá los routers' ) do
		options[:router] = true
	end

	opts.on( '-0', '--backup', 'Realizará el backup de las practicas 1, 2, 3 en ../backup/' ) do
		options[:back] = true
	end

	opts.on( '-1', '--backup1', 'Realizará el backup de las maquinas (qcow2) de la practica 1 en ../backup/' ) do
		options[:back1] = true
	end

	opts.on( '-2', '--backup2', 'Realizará el backup de las maquinas (qcow2) de la practica 2 en ../backup/' ) do
		options[:back2] = true
	end

	opts.on( '-3', '--backup3', 'Realizará el backup de las maquinas (qcow2) de la practica 3 en ../backup/' ) do
		options[:back3] = true
	end

	opts.on( '-l', '--lista', 'Mostrará la lista de las maquinas para conectarse' ) do
		options[:lista] = true
	end

	opts.on( '-c', '--conn', 'Se conectará mediante ssh a la máquina [nombreMaquina]' ) do|maquina|
		options[:conn] = maquina
	end

	opts.on( '-x', '--xml', 'Realizará los backups de los ficheros xml de las máquinas' ) do
		options[:xml] = true
	end





	opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
     exit
	end
end
#Con parse! eliminamos las opciones, de esta manera en ARGV quedara por ejemplo solo el nombre de la maquina
optparse.parse!


#COPIA DE SEGURIDAD DE TODOS LOS FICHEROS XML DE LAS MÁQUINAS
if options[:xml]

	P1.each do|r|
			system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.xml ../backup/")
			system("sleep 2")
	end
	P2.each do|r|
		system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.xml ../backup/")
		system("sleep 2")
	end
	P3.each do|r|
		system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.xml ../backup/")
		system("sleep 2")
	end

end

#COPIA DE SEGURIDAD DE LAS IMAGENES DE LA PRACTICA 1
if (options[:back] || options[:back1]) && !options[:shut] && !options[:on]

	P1.each do|r|
			system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.qcow2 ../backup/")
			system("sleep 2")
	end
end

#COPIA DE SEGURIDAD DE LAS IMAGENES DE LA PRACTICA 2
if (options[:back] || options[:back2]) && !options[:shut] && !options[:on]

	P2.each do|r|
			system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.qcow2 ../backup/")
			system("sleep 2")
	end
end

#COPIA DE SEGURIDAD DE LAS IMAGENES DE LA PRACTICA 3
if (options[:back] || options[:back3]) && !options[:shut] && !options[:on]

	P3.each do|r|
			system("scp a795809@155.210.154.204:/misc/alumnos/as2/as22022/a795809/#{r}.qcow2 ../backup/")
			system("sleep 2")
	end
end

#Apagado de máquinas
#APAGADO DE LAS MAQUINAS DE LA PRACTICA 1
if options[:shut] && options[:back1]

	P1.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system shutdown #{r}")
		system("sleep 2")
	end
end

#APAGADO DE LAS MAQUINAS DE LA PRACTICA 2
if options[:shut] && options[:back2]

	P2.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system shutdown #{r}")
		system("sleep 2")
	end
end

#APAGADO DE LAS MAQUINAS DE LA PRACTICA 3
if options[:shut] && options[:back3]

	P3.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system shutdown #{r}")
		system("sleep 2")
	end
end
#Apagado de los routers
if options[:shut]
	if options[:router]
		ROUTERS.each do|r|
			system("virsh -c qemu+ssh://a795809@155.210.154.204/system shutdown #{r}")
			system("sleep 2")
		end
	end
end

#Encendido de máquinas
#ENCENDIDO DE LAS MAQUINAS DE LA PRACTICA 1
if options[:on] && options[:back1]

	P1.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system start #{r}")
		system("sleep 2")
	end
end

#ENCENDIDO DE LAS MAQUINAS DE LA PRACTICA 2
if options[:on] && options[:back2]

	P2.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system start #{r}")
		system("sleep 2")
	end
end

#ENCENDIDO DE LAS MAQUINAS DE LA PRACTICA 3
if options[:on] && options[:back3]

	P3.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system start #{r}")
		system("sleep 2")
	end
end

#ENCENDIDO DE ROUTER
if options[:router] && !options[:shut]
	ROUTERS.each do|r|
		system("virsh -c qemu+ssh://a795809@155.210.154.204/system start #{r}")
		system("sleep 2")
	end
end

#CONEXION POR SSH
if options[:conn]
	puts "Conectandose a la máquina #{ARGV[0]} con ip #{ips["#{ARGV[0]}"]}"
	system("ssh -6 a795809@#{ips["#{ARGV[0]}"]}")
end
#MUESTRA LA LISTA DE LAS MÁQUINAS
if options[:lista]
	puts " Routers:
	#{ROUTERS[0]}
	#{ROUTERS[1]}"
	puts " Servidores DNS maestro y esclavo:
	#{P2[0]}
	#{P2[1]}"
	puts " Servidor DNS recursivo con cache y servidor NTP:
	#{P1[1]}"
	puts " Servidor NFS:
	#{P3[0]}"
	puts " Servidores FreeIPA maestro y réplica:
	#{P3[1]}
	#{P3[2]}"
	puts " Clientes nfs:
	#{P3[3]}
	#{P3[4]}"
end






