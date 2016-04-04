# lua-resty-fastpbkdf2
Lua bindings to fastpbkdf2

# Usage

pbkdf2.fastpbkdf2_hmac(password, salt, iterations, key_len, hash_type)

password = string

salt = string

iterations = integer

key_len = integer

hash_type = string [ sha1, sha256, sha512 ]

Example
```
local pbkdf2 = require "fastpbkdf2"
local keydata  = pbkdf2.fastpbkdf2_hmac(key, salt, iterations, 48, "sha256")
```

This is an experimental module. Use with caution.
