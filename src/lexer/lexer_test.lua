local Token = require("src.token.token")
local Token_Type = Token.TokenType
local Lexer = require("src.lexer.lexer")

local function testNextToken()
	local input = "=+(){},;"

	local tests = {
		{ expectedType = Token_Type.ASSIGN, expectedLiteral = "=" },
		{ expectedType = Token_Type.PLUS, expectedLiteral = "+" },
		{ expectedType = Token_Type.LPAREN, expectedLiteral = "(" },
		{ expectedType = Token_Type.RPAREN, expectedLiteral = ")" },
		{ expectedType = Token_Type.LBRACE, expectedLiteral = "{" },
		{ expectedType = Token_Type.RBRACE, expectedLiteral = "}" },
		{ expectedType = Token_Type.COMMA, expectedLiteral = "," },
		{ expectedType = Token_Type.SEMICOLON, expectedLiteral = ";" },
		{ expectedType = Token_Type.EOF, expectedLiteral = "" },
	}

	local l = Lexer:new(input)

	for i, tt in ipairs(tests) do
		local tok = l:NextToken()
		if tok.type ~= tt.expectedType then
			error(string.format("tests[%d] - tokentype wrong. expected=%q, got=%q", i, tt.expectedType, tok.type))
		end
		if tok.literal ~= tt.expectedLiteral then
			error(string.format("tests[%d] - literal wrong. expected=%q, got=%q", i, tt.expectedLiteral, tok.literal))
		end
	end
end

local function run_tests()
    testNextToken()
    print("All tests passed!")
end

return {
    run_tests = run_tests
}