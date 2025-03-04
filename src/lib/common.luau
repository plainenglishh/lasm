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

return common;
