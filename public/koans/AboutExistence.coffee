describe "the nature of existence", ->
  it "should have an operator to check for it", ->
    # you can ask it of things that don't exist
    expect(foo?).toEqual(FILL_ME_IN)
    # or things that do
    foo = "bar"
    expect(foo?).toEqual(FILL_ME_IN)
  
  it "should understand non-existant things", ->
    foo = undefined
    expect(foo?).toEqual(FILL_ME_IN)
    foo = null
    expect(foo?).toEqual(FILL_ME_IN)
    
  it "should short circuit rather than exploding", ->
    foo = {}
    expect(foo?.bar?.wuzzle).toEqual(FILL_ME_IN)
    foo.bar = 
      wuzzle: "wazzle"
    expect(foo?.bar?.wuzzle).toEqual(FILL_ME_IN)
