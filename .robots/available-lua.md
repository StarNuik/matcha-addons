These are standard Lua functions available in most Lua parsers. Arguably, we could just refer to the Lua web site, but a few functions differ slightly in Blizzard's implementation. They are all documented here for consistency.
Contents

Lua in the World of Warcraft API

Note that the World of Warcraft API does not provide all standard Lua functions. Notably, operating system and file I/O libraries are not present.
Lua Functions


In addition to this list, see also Debugging Functions.

    assert(value[, errormsg]) - asserts a value evaluates to true. If it is, returns value, otherwise causes a Lua error to be thrown.
    collectgarbage() - Forces garbage collection. (Added in 1.10.1)
    date(format, time) - Returns the current date according to the user's machine.
    difftime(t1, t2) - Calculate the number of seconds between time t1 to time t2.
    error("error message",level) - Throws an error with the given error message. Use pcall() (see below) to catch errors.
    gcinfo() - Returns the number of kB of add-on memory in use and the current garbage collection threshold (in kB). (Function gcinfo is deprecated; use collectgarbage("count") instead.[1])
    getfenv(function or integer) - Returns the table representing the environment of the given function or stack level.
    getmetatable(obj, mtable) - Returns the metatable of the given table or userdata object.
    loadstring("Lua code") - Parse the string as Lua code and return it as a function reference.
    next(table, index) - Returns the next key, value pair of the table, allowing you to walk over the table.
    newproxy(boolean or proxy) - Creates a userdata with a sharable metatable.
    pcall(func [, ...]) - Returns a boolean value indicating successful execution of func and the error message or func's results as additional values.
    select(index, list) - Returns the number of items in list or a subset of the list beginning at index and running to the end of the list.
    setfenv(function or integer, table) - Sets the table representing the stack frame of the given function or stack level.
    setmetatable(table, metatable) - Sets the metatable of the given table.
    time(table) - Returns time in seconds since epoch (00:00:00 Jan 1 1970)
    type(var) - Returns the type of variable as a string, "nil", "boolean", "number", "string", "table", "function", "thread" or "userdata". (The only Lua data types.)
    unpack(table[, start][, end]) - Returns the contents of its argument as separate values.
    xpcall(func, err [, ...]) - Returns a boolean indicating successful execution of func and calls err on failure, additionally returning func's or err's results.
    rawequal(value, value) - Compares two values for equality without invoking metamethods.
    rawget(table, index) - Gets the value of a table item without invoking metamethods.
    rawset(table, index, value) - Sets the value of a table item without invoking metamethods.

Math Functions

Most of these functions are shorthand references to the Lua math library (which is available via "math.", see MathLibraryTutorial for more info).

The trigonometry functions are not just references; they have degree→radian conversion wrappers. Blizzard's versions work with degrees. Lua's standard math library works with radians.

    abs(value) - Returns the absolute value of the number.
    acos(value) - Returns the arc cosine of the value in degrees.
    asin(value) - Returns the arc sine of the value in degrees.
    atan(value) - Returns the arc tangent of the value in degrees.
    atan2(y, x) - Returns the arc tangent of Y/X in degrees.
    ceil(value) - Returns the ceiling of value.
    cos(degrees) - Returns the cosine of the degree value.
    deg(radians) - Returns the degree equivalent of the radian value.
    exp(value) - Returns the exponent of value.
    floor(value) - Returns the floor of value.
    fmod(value,modulus) - Returns the remainder of the division of value by modulus that rounds the quotient towards zero.
    frexp(num) - Extract mantissa and exponent from a floating point number.
    ldexp(value, exponent) - Load exponent of a floating point number.
    log(value) - Returns the natural logarithm (log base e) of value.
    log10(value) - Returns the base-10 logarithm of value.
    max(value[, values...]) - Returns the numeric maximum of the input values.
    min(value[,values...]) - Returns the numeric minimum of the input values.
    mod(value,modulus) - Returns floating point modulus of value. (Function math.mod was renamed math.fmod)
    rad(degrees) - Returns the radian equivalent of the degree value.
    random([ [lower,] upper]) - Returns a random number (optionally bounded integer value)
    sin(degrees) - Returns the sine of the degree value.
    sqrt(value) - Return the square root of value.
    tan(degrees) - Returns the tangent of the degree value.


These are custom math functions available in WoW but not normal Lua.

    fastrandom([ [lower,] upper]) - Returns a random number (can't be used in secure enviorment but are faster than random and math.random)

String Functions

These string functions are shorthand references to the Lua string library (which is available via "string.", see StringLibraryTutorial for more info),

    format(formatstring[, value[, ...]]) - Return a formatted string using values passed in.
    gmatch(string, pattern) - This returns a pattern finding iterator. The iterator will search through the string passed looking for instances of the pattern you passed.
    gsub(string,pattern,replacement[, limitCount]) - Globally substitute pattern for replacement in string.
    strbyte(string[, index]) - Returns the internal numeric code of the i-th character of string
    strchar(asciiCode[, ...]) - Returns a string with length equal to number of arguments, with each character assigned the internal code for that argument.
    strfind(string, pattern[, initpos[, plain]]) - Look for match of pattern in string, optionally from specific location or using plain substring.
    strlen(string) - Return length of the string.
    strlower(string) - Return string with all upper case changed to lower case.
    strmatch(string, pattern[, initpos]) - Similar to strfind but only returns the matches, not the string positions.
    strrep(seed,count) - Return a string which is count copies of seed.
    strrev(string) - Reverses a string; alias of string.reverse.
    strsub(string, index[, endIndex]) - Return a substring of string starting at index
    strupper(string) - Return string with all lower case changed to upper case.
    tonumber(arg[, base]) - Return a number if arg can be converted to number. Optional argument specifies the base to interpret the numeral. Bases other than 10 accept only unsigned integers.
    tostring(arg) - Convert arg to a string.


These are custom string functions available in WoW but not normal Lua.

    strcmputf8i(string, string) - string comparison accounting for UTF-8 chars
    strlenutf8(string) - Returns the number of characters in a UTF8-encoded string.
    strtrim(string[, chars]) - Trim leading and trailing spaces or the characters passed to chars from string.
    strsplit(delimiter, string [, pieces) - Splits a string using a delimiter.
    strsplittable(delimiter, subject [, pieces])
    strjoin(delimiter, string, string[, ...]) - Join string arguments into a single string, separated by delimiter.
    strconcat(...) - Returns a concatenation of all number/string arguments passed.
    tostringall(...) - Converts all arguments to strings and returns them in the same order that they were passed.

Table Functions

These table functions are shorthand references to the Lua table library (which is available via "table.", see TableLibraryTutorial for more info).

Be also aware that many table functions are designed to work with tables indexed only with numerical indexes, starting with 1 and without holes (like {[1] = "foo", [3] = "bar"} --- recognize that [2] will be nil in this table). When working with any other tables behavior is not defined and might lead to unexpected results. Not being aware of this fact is one major causes for bugs in code written in Lua.

    ipairs(table) - Returns an iterator of type integer to traverse a table.
    pairs(table) - Returns an iterator to traverse a table.
    sort(table[, comp]) - Sort the elements in the table in-place, optionally using a custom comparator.
    tContains(table, value) - returns true if value is contained within table. This is not standard Lua, but added by Blizzard.
    tinsert(table[, pos], value) - Insert value into the table at position pos (defaults to end of table)
    tremove(table[, pos]) - Remove and return the table element at position pos (defaults to last entry in table)
    wipe(table) - Restore the table to its initial value (like tab = {} without the garbage). This is not standard Lua, but added by Blizzard.

These are custom table functions available in WoW but not normal Lua.

    table.removemulti(table[, pos][, count]) - Removes count elements from a table starting at index pos. Defaults to removing only the last entry in table.

The following functions are deprecated and should not be used.

    foreach(table,function) - Execute function for each element in table. (deprecated, used pairs instead)
    foreachi(table,function) - Execute function for each element in table, indices are visited in sequential order. (deprecated, used ipairs instead)
    getn(table) - Return the size of the table when seen as a list. This is deprecated, it is replaced by the # operator. Instead of table.getn(table), use #(table).

Bit Functions

World of Warcraft includes the Lua bitlib library (available via the "bit" table) which provides access to bit manipulation operators. It has been available since Patch 1.9. This library seems to work internally with standard 32-bit 'int' values, since bit.lshift(0x80000000, 1) == 0

    bit.bnot(a) - binary 'not' - the one's complement of a
    bit.band(a1, ...) - binary 'and' - the bitwise and of the values
    bit.bor(a1, ...) - binary 'or' - the bitwise or of the values
    bit.bxor(a1, ...) - bitwise 'xor' - the bitwise exclusive or of the values
    bit.lshift(a, n) - 'left shift' - a shifted left by n bits
    bit.rshift(a, n) - 'right shift' - a shifted right by n bits
    bit.arshift(a, n) - 'arithmetic right shift' - a shifted right arithmetically by n bits
    bit.mod(a, n) - signed 'modulus' - the signed value of a modulo n (result is the same sign as a)

Using these functions to pack data structures is fairly slow work. Unless you have a very large database and need to conserve memory, save your information in several, individual variables or table fields.
Coroutine Functions

Coroutine functions should be used sparingly because of the amount of memory they use.

    coroutine.create(f)
    coroutine.resume(co [, val1, ...])
    coroutine.running()
    coroutine.status(co)
    coroutine.wrap(f)
    coroutine.yield(...)

Details
String Functions

    All strings have their metatable set to index the global string table, so any string function may be called through it with the colon syntax:

-- This...
local s = string.format(input, arg1, arg2, ...)

-- ...can be written as this
local s = input:format(arg1, arg2, ...)  -- input gets passed as the first argument, replicating the above code, as per the colon syntax

To make this work for string constants, you have to use parentheses. "%d":format(arg1) is not valid Lua code, you have to do

("%d"):format(arg1)

Table Functions

    Any function that takes a table as its first argument can be assigned to a method in said table and used thusly.
        There's no practical reason for doing this, but it's kinda fun to know these useless things.
        Notice that table.wipe (and wipe) will remove itself and all other methods assigned in this manner.

tab = {}

-- this works, of course.
tinsert(tab, 1, value) -- change the value at index 1 to value.

-- as does this
tab.insert = tinsert
tab:insert(1, value) -- change the value at index 1 to value (note the ":").

See also