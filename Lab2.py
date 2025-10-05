import hashlib


def find_hash_with_zeros(iin, target_zeros=2):
    counter = 1
    target_prefix = '0' * target_zeros

    while True:
        input_string = f"{iin}+{counter}"
        hash_result = hashlib.sha256(input_string.encode()).hexdigest()

        if hash_result.startswith(target_prefix):
            return counter, input_string, hash_result

        counter += 1


iin = "020103512347"
number, original_text, hash_result = find_hash_with_zeros(iin, 2)

print(f"Число: {number}")
print(f"Исходный текст: {original_text}")
print(f"SHA256 хэш: {hash_result}")