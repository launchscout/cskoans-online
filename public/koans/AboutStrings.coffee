describe "About String", ->
  it "makes its easy to put variables in my strings", ->
    fruit = "apples"
    expect(FILL_ME_IN).toEqual("I like to eat #{fruit}")
  it "splits strings", ->
    expect("cat,apple,chair".split(",")).toEqual(FILL_ME_IN)
  it "joins strings", ->
    expect([1, 2, 3].join(",")).toEqual(FILL_ME_IN)