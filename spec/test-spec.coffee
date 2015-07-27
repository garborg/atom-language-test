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

  it "passes the baseline", ->
    {tokens} = grammar.tokenizeLine("catinhat")
    console.log(tokens)
    expect(tokens[0]).toEqual value: "cat", scopes: ["source.test", "p1.hat.test"]
    expect(tokens[1]).toEqual value: "in", scopes: ["source.test", "p1.hat.test"]
    expect(tokens[2]).toEqual value: "hat", scopes: ["source.test", "p1.hat.test"]

  it "understands 'inboots' doesn't contain 'hat' but contains 'boots'", ->
    {tokens} = grammar.tokenizeLine("catinboots")
    console.log(tokens)
    expect(tokens[0]).toEqual value: "cat", scopes: ["source.test", "p2.boots.test"]
    expect(tokens[1]).toEqual value: "in", scopes: ["source.test", "p2.boots.test"]
    expect(tokens[2]).toEqual value: "boots", scopes: ["source.test", "p2.boots.test"]
