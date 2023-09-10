///@func classful_json_test_encode()
///@desc Test Classful JSON stringify.
function classful_json_test_encode() {
    var fixture, expected, got;
    
    fixture = new ClassfulJsonBlank();
    expected = @'{"_class_":"ClassfulJsonBlank"}';
    got = json_stringify_classful(fixture);
    assert_equal(got, expected, "json_stringify_classful simple test case failed!");
    
    fixture = new ClassfulJsonBlank();
    expected = @'{"klass":"ClassfulJsonBlank"}';
    got = json_stringify_classful(fixture, false, "klass");
    assert_equal(got, expected, "json_stringify_classful simple test case with custom classfield failed!");
    
    //fixture = new ClassfulJsonBlank();
    fixture = new ClassfulJsonVector2(3, 4);
    got = json_stringify_classful(fixture, true);
    assert_contains(got, "  ", "json_stringify_classful simple test case with prettify has no indents!");
    assert_contains(got, @'"x"', "json_stringify_classful simple test case with prettify has no x!");
    assert_contains(got, @'"y"', "json_stringify_classful simple test case with prettify has no y!");
    assert_contains(got, @'"_class_"', "json_stringify_classful simple test case with prettify has no class field!");
    
    fixture = [new ClassfulJsonBlank(), new ClassfulJsonBlank(), "foo"];
    expected = @'[{"_class_":"ClassfulJsonBlank"},{"_class_":"ClassfulJsonBlank"},"foo"]';
    got = json_stringify_classful(fixture);
    assert_equal(got, expected, "json_stringify_classful simple array-nested test case failed!");
    
    fixture = { foo: new ClassfulJsonBlank() };
    expected = @'{"foo":{"_class_":"ClassfulJsonBlank"}}';
    got = json_stringify_classful(fixture);
    assert_equal(got, expected, "json_stringify_classful simple struct-nested test case failed!");
    
    fixture = {foo: [{ bar: new ClassfulJsonBlank() }]};
    expected = @'{"foo":[{"bar":{"_class_":"ClassfulJsonBlank"}}]}';
    got = json_stringify_classful(fixture);
    assert_equal(got, expected, "json_stringify_classful simple deep-nested test case failed!");
    
    fixture = new ClassfulJsonVector2(3, 4);
    expected = { _class_: "ClassfulJsonVector2", x: 3, y: 4 };
    got = json_parse(json_stringify_classful(fixture));
    assert_equal(got, expected, "json_stringify_classful test case failed!");
    
    fixture = new ClassfulJsonList("foo", new ClassfulJsonVector2(3, 4), ["bar", { baz: "qux" }, new ClassfulJsonBlank()]);
    expected = { _class_: "ClassfulJsonList", data: ["foo", { _class_: "ClassfulJsonVector2", x: 3, y: 4 },["bar", { baz: "qux" }, { _class_: "ClassfulJsonBlank" }]]};
    got = json_parse(json_stringify_classful(fixture));
    assert_equal(got, expected, "json_stringify_classful complex test case failed!");
}
