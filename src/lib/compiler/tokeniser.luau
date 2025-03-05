local t = require("../typedefs");

type Tokeniser = {
    peek: () -> t.Token?,
    next: () -> t.Token?,
    at_end: () -> boolean,
};

local tokeniser = {};

function tokeniser.tokenise(char_stream: t.PeekableCharacterStream): Tokeniser
    local self = {};
    local peek_cache;

    function self.peek(): t.Token?
        if not self.peek() then  
            return nil;
        end

        local lexeme_start = char_stream.position();

        local function current_span(): t.Span
            return t.Span(lexeme_start, char_stream.position());
        end

        local function Token(type: t.TokenType, lexeme: string, literal: any?): t.Token
            return {
                type = type,
                literal = literal,
                lexeme = lexeme,
                span = current_span(),
            };
        end        

        local function ErrToken(name: string, ...): t.Token
            return Token("ERROR");
        end

        local char = char_stream.next();
        
        if char == "" then
        else
            return ErrToken("UnexpectedCharacter");
        end

        return ErrToken("UnexpectedEOF");
    end

    function self.next(): t.Token?
        return self.peek();
    end

    function self.at_end(): boolean
        return char_stream.peek() == nil;
    end

    return self;
end

return tokeniser;