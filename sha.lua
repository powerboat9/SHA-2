local msg = ...
assert(type(msg) == "string", "The message has to be a string")

function hexToNumb(s) --Assumes big edien
    s = s:lower()
    local numb = 0
    for i = 1, #s do
        local value = assert(("0123456789abcdef"):find(s:sub(i, i)), "Invalid Charicter At Index " .. i) - 1
        numb = numb + value * (16 ^ (#s - i))
    end
    return numb
end

function numbToHex(n)
    assert((type(n) == "number") and (n >= 0) and (n < (16 ^ 8)), "The number is too big, negative, or not a number")
    local hex = ""
    for i = 8, 1, -1 do
        local times = math.floor(n / (16 ^ (i - 1)))
        hex = hex .. ("0123456789abcdef"):sub(times + 1, times + 1)
        n = n - times * (16 ^ (i - 1))
    end
    return hex
end

function numbToBits(n)
    --Line below copied from "numbToHex"
    assert((type(n) == "number") and (n >= 0) and (n < (16 ^ 8)), "The number is too big, negative, or not a number")
    local bits = {}
    for i = 32, 1, -1 do
        local value = (2 ^ (i - 1))
        if n >= value then
            n = n - value
            bits[i] = true
        else
            bits[i] = false
        end
    end
    return bits
end

local hashValues = {
    "6a09e667",
    "bb67ae85",
    "3c6ef372",
    "a54ff53a",
    "510e527f",
    "9b05688c",
    "1f83d9ab",
    "5be0cd19"
}

local roundConstants = {
    "428a2f98",
    "71374491",
    "b5c0fbcf",
    "e9b5dba5",
    "3956c25b",
    "59f111f1",
    "923f82a4",
    "ab1c5ed5",
    "d807aa98",
    "12835b01",
    "243185be",
    "550c7dc3",
    "72be5d74",
    "80deb1fe",
    "9bdc06a7",
    "c19bf174",
    "e49b69c1",
    "efbe4786",
    "0fc19dc6",
    "240ca1cc",
    "2de92c6f",
    "4a7484aa",
    "5cb0a9dc",
    "76f988da",
    "983e5152",
    "a831c66d",
    "b00327c8",
    "bf597fc7",
    "c6e00bf3",
    "d5a79147",
    "06ca6351",
    "14292967",
    "27b70a85",
    "2e1b2138",
    "4d2c6dfc",
    "53380d13",
    "650a7354",
    "766a0abb",
    "81c2c92e",
    "92722c85",
    "a2bfe8a1",
    "a81a664b",
    "c24b8b70",
    "c76c51a3",
    "d192e819",
    "d6990624",
    "f40e3585",
    "106aa070",
    "19a4c116",
    "1e376c08",
    "2748774c",
    "34b0bcb5",
    "391c0cb3",
    "4ed8aa4a",
    "5b9cca4f",
    "682e6ff3",
    "748f82ee",
    "78a5636f",
    "84c87814",
    "8cc70208",
    "90befffa",
    "a4506ceb",
    "bef9a3f7",
    "c67178f2"
}

local newMsg = ""
do
    for k, v in msg:gmatch(".") do
        local b = 
