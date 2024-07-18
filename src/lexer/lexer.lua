local Token_Module = require("src.token.token")
local Token = Token_Module.Token
local Token_Type = Token_Module.TokenType

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
        tok = newToken(Token_Type.ASSIGN, self.ch)
    elseif self.ch == ";" then
        tok = newToken(Token_Type.SEMICOLON, self.ch)
    elseif self.ch == "(" then
        tok = newToken(Token_Type.LPAREN, self.ch)
    elseif self.ch == ")" then
        tok = newToken(Token_Type.RPAREN, self.ch)
    elseif self.ch == "," then
        tok = newToken(Token_Type.COMMA, self.ch)
    elseif self.ch == "+" then
        tok = newToken(Token_Type.PLUS, self.ch)
    elseif self.ch == "{" then
        tok = newToken(Token_Type.LBRACE, self.ch)
    elseif self.ch == "}" then
        tok = newToken(Token_Type.RBRACE, self.ch)
    elseif self.ch == "" then
        tok = newToken(Token_Type.EOF, "")
    else
        -- Handle unknown character (optional)
        tok = newToken("ILLEGAL", self.ch)
    end

    self:readChar()  -- Advance to the next character
    return tok
end

-- Return the Lexer table to allow importing in other scripts
return Lexer