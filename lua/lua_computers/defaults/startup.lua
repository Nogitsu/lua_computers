local args = { ... }

reboot = false

print( os.getComputerID() )
os._computer.id = args[ 1 ]
print( os.getComputerID() )

print "hiiii" 

os.sleep( 1 )

print( "1s later..", reboot )

for i = 0, 10 do
    term.setCursorPos( i, i )
    term.setTextColor( math.random( 255 ), math.random( 255 ), math.random( 255 ) )
    term.write( "Line #" .. i )
end

if not reboot then 
    reboot = true
    os.shutdown()
end

print( "called only after the reboot" )