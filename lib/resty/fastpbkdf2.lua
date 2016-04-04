-- Lua FFI for fastpbkdf2 ( https://github.com/ctz/fastpbkdf2 )
-- License - CC0 - https://creativecommons.org/publicdomain/zero/1.0/
-- Written by Chris Federico - 2016

local _M = {}

local ffi          = require "ffi"
local ffi_load 	   = ffi.load
local ffi_new      = ffi.new
local ffi_cdef     = ffi.cdef
local ffi_string   = ffi.string

ffi_cdef[[
void fastpbkdf2_hmac_sha1(const uint8_t *pw, size_t npw,
                          const uint8_t *salt, size_t nsalt,
                          uint32_t iterations,
                          uint8_t *out, size_t nout);

void fastpbkdf2_hmac_sha256(const uint8_t *pw, size_t npw,
                            const uint8_t *salt, size_t nsalt,
                            uint32_t iterations,
                            uint8_t *out, size_t nout);

void fastpbkdf2_hmac_sha512(const uint8_t *pw, size_t npw,
                            const uint8_t *salt, size_t nsalt,
                            uint32_t iterations,
                            uint8_t *out, size_t nout);
]]

local fastpbkdf2 = ffi_load("libfastpbkdf2")

--[[  fastpbkdf2 requires the following arguments
password = string
salt = string
iterations = integer
key_len = integer
hash_type = [ sha1, sha256, sha512 ]

Returns ffi string
]]--

function _M.fastpbkdf2_hmac(password, salt, iterations, key_len, hash_type)

    local c_out = ffi.new("uint8_t[?]", key_len)

    if hash_type == "sha1" then
        fastpbkdf2.fastpbkdf2_hmac_sha1(
            password,
            #password,
            salt,
            #salt,
            iterations,
            c_out,
            key_len
        )
        return ffi_string(c_out,key_len)

    elseif hash_type == "sha256" then

        fastpbkdf2.fastpbkdf2_hmac_sha256(
            password,
            #password,
            salt,
            #salt,
            iterations,
            c_out,
            key_len
        )
        return ffi_string(c_out,key_len)

    elseif hash_type == "sha512" then
        fastpbkdf2.fastpbkdf2_hmac_sha512(
            password,
            #password,
            salt,
            #salt,
            iterations,
            c_out,
            key_len
        )
        return ffi_string(c_out,key_len)

    else
	assert(false,"Hash type must be either sha1, sha256, or sha512")
    end

end

return _M
