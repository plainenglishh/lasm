local common = require("./common");
local t = require("./typedefs");

local function fmt(msg: string)
    return common.bind(string.format, msg);
end

local function raw(msg: string)
    return function()
        return msg; 
    end;
end

local errors = {};

errors.codes = {
    [1] = {
        name = "UnexpectedToken", 
        type = "SyntaxError", 
        message = fmt("expected token %*, got %*") 
    },

    [2] = {
        name = "UnexpectedEOF",
        type = "SyntaxError",
        message = raw("unexpected EOF"),
    },

    [3] = { 
        name = "MalformedNumber", 
        type = "SyntaxError", 
        message = fmt("malformed number %*") 
    },

} :: {t.ErrorInfo};

function errors.get_error_by_name(name: string): t.ErrorInfo?
    for _, e in errors.codes do
        if e.name == name then
            return e;
        end
    end

    return nil;
end

function errors.get_message(name: string, ...): string
    local err = errors.get_error_by_name(name) or common.compiler_panic(`no error '{name}'`);
    return err.message(...);
end

function errors.get_type(name: string): t.ErrorType
    local err = errors.get_error_by_name(name) or common.compiler_panic(`no error '{name}'`);
    return err.type;
end

return errors;