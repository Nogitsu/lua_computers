local args = { ... }

reboot = false

print( os.getComputerID() )
os._computer.id = args[ 1 ]
print( os.getComputerID() )

print "hiiii" 

os.sleep( 1 )

print( "1s later..", reboot )


if not reboot then 
    reboot = true
    os.shutdown()
end

print( "called only after the reboot" )