import binascii

keyAsBits = ""
keyAsHex = ""

with open('challenges/dmf86', 'r') as dmf86:
    msgs = dmf86.readlines()

    # Remove signature word, split by semicolon
    msgs = [msg.replace('\n', '').split('; Signature: ') for msg in msgs] 

    # Convert signature to int -> bits -> and then grab least significant bit
    for msg in msgs:
    	signatureAsInt = int(msg[1], 16)
    	signatureAsBits = format(signatureAsInt, "0192b")
    	
    	keyAsBits += signatureAsBits[-1]

    keyAsHex = hex(int(keyAsBits, 2))

print(keyAsHex)