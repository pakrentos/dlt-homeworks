import hashlib
import time
from fastapi import FastAPI



max_nonce = 2 ** 32 # 4 billion

def proof_of_work(header, difficulty_bits):

	target = 2 ** (256-difficulty_bits)
	for nonce in range(max_nonce):
		hash_result = hashlib.sha256((str(header)+str(nonce)).encode()).hexdigest()

		if int(hash_result, 16) < target:
			print("Success with nonce %d" % nonce)
			print("Hash is %s" % hash_result)
			return hash_result, nonce

	print("Failed after %d (max_nonce) tries" % nonce)
	return 'Not get', 0


app = FastAPI()


@app.get("/")
async def get_bits(bits: int = 0):
    start_time = time.time()
    hash_result = ''
    new_block = 'test block with transactions' + hash_result
    (hash_result, nonce) = proof_of_work(new_block, bits)
    print(hash_result, nonce)
    end_time = time.time()
    elapsed_time = end_time - start_time
    print("Elapsed time: %.4f seconds" % elapsed_time)
    if elapsed_time > 0:
        hash_power = float(int(nonce)/elapsed_time)
        print("Hashing power: %ld hashes per second" % hash_power)

    return {'hash':hash_result, 'nonce':nonce}