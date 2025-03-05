local t = require("./typedefs");

local common = {};

function common.bind(fn: (...any) -> ...any, ...): (...any) -> ...any
    local args = table.pack(...);

    return function(...: any): ...any
        fn(table.unpack(args), ...);
    end
end

function common.compiler_panic(msg: string): never
    error(`internal compiler error: {msg}`);
end

function common.char_stream(buf: string|buffer): t.PeekableCharacterStream
    local buf = if type(buf) == "string" then buffer.fromstring(buf) else buf;
    local len = buffer.len(buf);

    local cursor = 0;

    local self = {};

    function self.peek(): string?
        if cursor >= len then
            return nil;
        end

        return string.char(buffer.readu8(buf, cursor));
    end

    function self.next(): string?
        local char = self.peek();
        if not char then
            return nil;
        end
        cursor += 1;
        return char;
    end

    function self.position(): number
        return cursor;
    end

    return self;
end

return common;
