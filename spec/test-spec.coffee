describe "Test grammar", ->
  grammar = null
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-test")
    runs ->
      grammar = atom.grammars.grammarForScopeName("source.test")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.test"

  it "does what I want", ->
    {tokens} = grammar.tokenizeLine("f(x)yy")
    console.log(tokens)
    expect(tokens[0]).toEqual value: "f", scopes: ["source.test", "fcall.test", "support.function.test"]
    expect(tokens[1]).toEqual value: "(", scopes: ["source.test", "fcall.test", "paren.open.call.test"]
    expect(tokens[2]).toEqual value: "x", scopes: ["source.test", "fcall.test"]
    expect(tokens[3]).toEqual value: ")", scopes: ["source.test", "fcall.test", "paren.close.call.test"]
    expect(tokens[4]).toEqual value: "yy", scopes: ["source.test"]

  it "does what I don't want", ->
    {tokens} = grammar.tokenizeLine("f(x)yy")
    console.log(tokens)
    expect(tokens[0]).toEqual value: "f", scopes: ["source.test", "fdecl.test", "entity.name.function.test"]
    expect(tokens[1]).toEqual value: "(", scopes: ["source.test", "fdecl.test", "paren.open.decl.test"]
    expect(tokens[2]).toEqual value: "x)yy", scopes: ["source.test", "fdecl.test"]
