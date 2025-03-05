local t = {};

export type Span = {
    start: number,
    stop: number,
};

function t.Span(start: number, stop: number): Span
    return {
        start = start,
        stop = stop,
    };
end

export type TokenType = 
    "ERROR"-- TODO!;

export type Token = {
    type: TokenType,
    span: Span,
    lexeme: string,
    literal: any?,
};

export type CompileErrorType = 
    "SyntaxError";

export type CompileError = {
    type: CompileErrorType,
    message: string,
    span: Span,
};

export type CompileErrorInfo = {
    name: string,
    type: CompileErrorType,
    message: (...any) -> string,
};

export type PeekableCharacterStream = {
    peek: () -> string?,
    next: () -> string?,
    position: () -> number,
};

return t;