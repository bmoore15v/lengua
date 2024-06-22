local Token = {}
Token.__index = Token

function Token:new(type, literal)
	local token = {
		type = type,
		literal = literal,
	}

	setmetatable(token, self)
	return token
end

local TokenType = {
	ILLEGAL = "ILLEGAL",
	EOF = "EOF",

	-- Identifiers + literals
	IDENT = "IDENT", -- add, foobar, x, y, ...
	INT = "INT", -- 123456

	-- Operators
	ASSIGN = "=",
	PLUS = "+",

	-- Delimiters
	COMMA = ",",
	SEMICOLON = ";",
	LPAREN = "(",
	RPAREN = ")",
	LBRACE = "{",
	RBRACE = "}",

	-- Keywords
	FUNCTION = "FUNCTION",
	LET = "LET",
}

return {
	Token = Token,
	TokenType = TokenType,
}
