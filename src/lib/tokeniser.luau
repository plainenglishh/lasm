local t = require("./typedefs");
local errors = require("./errors");

local tokeniser = {};

--[[
    Terms:
        emit    - emits an item
        is      - returns whether a character falls within a character class
        consume - match a series of characters and discard the results
        match   - try to match a pattern, returning whether it was successful.
]]

function tokeniser.tokenise(src: buffer): t.TokeniseResult
    local lexeme_start = 0;
    local cursor = 0;
    local tokens: {t.Token} = {};
    local tokenise_errors: {t.Error} = {};

    --[=[
        Emits a token.
    ]=]
    local function emit_token(type: t.TokenType, literal: any?)
        table.insert(tokens, {
            type = type,
            lexeme = buffer.readstring(src, lexeme_start, cursor - lexeme_start),
            literal = literal,
            span = {
                start = lexeme_start,
                stop = cursor,
            },
        });
    end

    --[=[
        Reports an error.
    ]=]
    local function emit_error(err_name: string, ...)
        table.insert(tokenise_errors, {
            type = errors.get_type(err_name),
            message = errors.get_message(err_name),
            span = {
                start = lexeme_start,
                stop = cursor,
            },
        });
    end

    --[=[
        Returns whether the cursor is at the end of the buffer.
    ]=]
    local function at_eof(location: number?): boolean
        local location = location or cursor;
        return location == buffer.len(src);
    end

    --[=[
        Returns the next character without advancing.
    ]=]
    local function lookahead(): string
        local char = string.char(buffer.readu8(src, cursor));
        return char;
    end

    --[=[
        Advances the cursor by one character.
    ]=]
    local function advance(): string
        local char = string.char(buffer.readu8(src, cursor));
        cursor += 1;
        return char;
    end

    --[=[
        Returns true and advances if the next character matches the passed value.
    ]=]
    local function match(char: string): boolean
        if lookahead() == char then
            advance();
            return true;
        end

        return false;
    end

    --[=[
        Returns whether the passed character is a numeric digit.
    ]=]
    local function is_numeric(char: string): boolean
        local byte = string.byte(char);
        return byte >= 48 and byte <= 57;
    end

    --[=[
        Returns whether the passed character is a letter.
    ]=]
    local function is_alpha(char: string): boolean
        local byte = string.byte(string.lower(char));
        return (byte >= 97 and byte <= 122) or byte == 95;
    end

    --[=[
        Returns whether the passed character is alphabetical or '_'.
    ]=]
    local function is_alphanumeric(char: string): boolean
        return is_alpha(char) or is_numeric(char);
    end

    --[=[
        Returns whether a passed character is a hexadecimal digit.
    ]=]
    local function is_hex(char: string)
        local char = string.lower(char);
        local byte = string.byte(char);

        return is_numeric(char) or byte >= 97 and byte <= 102;
    end

    --[=[
        Returns whether the passed character is whitespace.
    ]=]
    local function is_whitespace(char: string): boolean
        local byte = string.byte(string.lower(char));
        return byte == 0x20 or byte == 0x09 or byte == 0x0D or byte == 0x0A;
    end

    --[=[
        Matches whitespace, discarding it.
    ]=]
    local function consume_whitespace()
        while not at_eof() do
            if is_whitespace(lookahead()) then
                advance();
            else
                break;
            end
        end
    end


    return {
        tokens = tokens,
        errors = errors,
    };
end

return tokeniser;