## Question 1

The deployed contract is at address: `0x5d730c10042376601efc12aa08544b3eed61393d`

## Question 2

The deployed contract is at address: `0xdcFb3F8964fB0cC5150EC94E3e29ff6e83415CE3`

## Question 3

1. The master key is: `0x2690ddf94122d69dcc51a59bf64978675189cac2c5a1d8a8`
2. The backdoor is vulnerable in that it requires 192 transactions in the same wallet to recover the key. If the owner is prudent and sends the remainder UTXO amounts to a new wallet that she also owns (with a different private key), she will never get to 192 transactions.
3. We could run the ECDSA signature algorithm more times in order to represent more bytes of the master key in the transactino signature. However, this quickly becomes unrealistic after more than a few bytes. Trying to represent n bytes in a single transaction results in an expected generation of 2^n ECDSA signatures. Even though this becomes computationally intensive quickly, we could, for example, realistically bring the required number of transactions down to 32 by representing 6 bits in each transaction, requiring an expected 64 signatures until we find one with the 6 least significant bits in the right configuration.

### Solution Code
```python
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
```

## Question 4

| Input Address | Input Amount | Output Address | Output Amount |
| ------------- | -----------: | -------------- | ------------: |
| 1MVXpgczazLvbtS8Nfp9v3Qpj4d8pUNXQM | 0.25 BTC | MTbp4bFftessrbTTpM5SC5Ap1iKaMHrM7 | 0.02441339 BTC |
| 135g5Es7VXvbaAkwzguv7q7xaSSTifav5H | 0.05 BTC | MUZ1Qk36LqExdcSRDZCxNRP1pcz1b5mT | 0.04044 BTC |
| 1GcZjZnfQUCs9L9RoAFLdd8YET2WQWrDAz | 0.01 BTC | 18RwKzXtL5YGvFwa9BHrPRvqXLkdYWsGfp | 0.00987 BTC |
| 1KGhtebk4Nr2zZSn2NaFepeNF6KyjxpPJZ | 0.02 BTC | BCaztysy2paguXjuC8c652vckNMks69ce | 0.01986549 BTC |

It is fairly trivial to see that the amounts from the input transaction are a small amount larger than the matching amounts from the output transactions, minus a small transaction and possibly service fee.