local token_module = require("src.token.token")
local Token = token_module.Token
local token_type = token_module.TokenType

-- Define the Lexer table
local Lexer = {}
Lexer.__index = Lexer

-- Constructor function for creating a new Lexer instance
function Lexer:new(input)
    local l = {
        input = input,
        position = 1,      -- current position in input (points to current char)
        readPosition = 1,  -- current reading position in input (after current char)
        ch = ""            -- current char under examination
    }
    setmetatable(l, Lexer)
    l:readChar()  -- Call readChar to initialize the first character
    return l
end

-- Function to read the next character
function Lexer:readChar()
    if self.readPosition > #self.input then
        self.ch = ""  -- End of input, set ch to an empty string
    else
        self.ch = self.input:sub(self.readPosition, self.readPosition)
    end
    self.position = self.readPosition
    self.readPosition = self.readPosition + 1
end

-- Function to create a new token
local function newToken(tokenType, ch)
    return Token:new(tokenType, ch)
end

-- Method to get the next token
function Lexer:NextToken()
    local tok

    -- Switch case to determine token type
    if self.ch == "=" then
        tok = newToken(token_type.ASSIGN, self.ch)
    elseif self.ch == ";" then
        tok = newToken(token_type.SEMICOLON, self.ch)
    elseif self.ch == "(" then
        tok = newToken(token_type.LPAREN, self.ch)
    elseif self.ch == ")" then
        tok = newToken(token_type.RPAREN, self.ch)
    elseif self.ch == "," then
        tok = newToken(token_type.COMMA, self.ch)
    elseif self.ch == "+" then
        tok = newToken(token_type.PLUS, self.ch)
    elseif self.ch == "{" then
        tok = newToken(token_type.LBRACE, self.ch)
    elseif self.ch == "}" then
        tok = newToken(token_type.RBRACE, self.ch)
    elseif self.ch == "" then
        tok = newToken(token_type.EOF, "")
    else
        -- Handle unknown character (optional)
        tok = newToken("ILLEGAL", self.ch)
    end

    self:readChar()  -- Advance to the next character
    return tok
end

-- Return the Lexer table to allow importing in other scripts
return Lexer