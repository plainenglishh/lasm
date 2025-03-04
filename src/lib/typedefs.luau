export type TokeniseResult = {
    errors: {Error},
    tokens: {Token},
};

export type Span = {
    start: number,
    stop: number,
};

export type TokenType = 
    ""-- TODO!;

export type Token = {
    type: TokenType,
    span: Span,
    lexeme: string,
    literal: any?,
};

export type ErrorType = 
    "SyntaxError";

export type Error = {
    type: ErrorType,
    message: string,
    span: Span,
};

export type ErrorInfo = {
    name: string,
    type: ErrorType,
    message: (...any) -> string,
};

local t = {};
return t;