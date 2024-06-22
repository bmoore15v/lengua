local token_module = require("src.token.token")
local token = token_module.TokenType

local function testNextToken()
	local input = "=+(){},;"

	local tests = {
		{ expectedType = token.ASSIGN, expectedLiteral = "=" },
		{ expectedType = token.PLUS, expectedLiteral = "+" },
		{ expectedType = token.LPAREN, expectedLiteral = "(" },
		{ expectedType = token.RPAREN, expectedLiteral = ")" },
		{ expectedType = token.LBRACE, expectedLiteral = "{" },
		{ expectedType = token.RBRACE, expectedLiteral = "}" },
		{ expectedType = token.COMMA, expectedLiteral = "," },
		{ expectedType = token.SEMICOLON, expectedLiteral = ";" },
		{ expectedType = token.EOF, expectedLiteral = "" },
	}

	local l = Lexer:new(input)

	for i, tt in ipairs(tests) do
		local tok = l:nextToken()
		if tok.type ~= tt.expectedType then
			error(string.format("tests[%d] - tokentype wrong. expected=%q, got=%q", i, tt.expectedType, tok.type))
		end
		if tok.literal ~= tt.expectedLiteral then
			error(string.format("tests[%d] - literal wrong. expected=%q, got=%q", i, tt.expectedLiteral, tok.literal))
		end
	end
end

testNextToken()
print("All tests passed!")
