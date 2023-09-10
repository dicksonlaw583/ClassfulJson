///@func classful_json_test_decode()
///@desc Test Classful JSON parse.
function classful_json_test_decode() {
    var fixture, expected, got;
    
    expected = new ClassfulJsonBlank();
    fixture = @'{"_class_":"ClassfulJsonBlank"}';
    got = json_parse_classful(fixture)
    assert_equal(got, expected, "json_parse_classful simple test case failed!");
    
    expected = new ClassfulJsonBlank();
    fixture = @'{"klass":"ClassfulJsonBlank"}';
    got = json_parse_classful(fixture, "klass");
    assert_equal(got, expected, "json_parse_classful simple test case with custom classfield failed!");
    
    expected = [new ClassfulJsonBlank(), new ClassfulJsonBlank(), "foo"];
    fixture = @'[{"_class_":"ClassfulJsonBlank"},{"_class_":"ClassfulJsonBlank"},"foo"]';
    got = json_parse_classful(fixture)
    assert_equal(got, expected, "json_parse_classful simple array-nested test case failed!");
    
    expected = { foo: new ClassfulJsonBlank() };
    fixture = @'{"foo":{"_class_":"ClassfulJsonBlank"}}';
    got = json_parse_classful(fixture)
    assert_equal(got, expected, "json_parse_classful simple struct-nested test case failed!");
    
    expected = {foo: [{ bar: new ClassfulJsonBlank() }]};
    fixture = @'{"foo":[{"bar":{"_class_":"ClassfulJsonBlank"}}]}';
    got = json_parse_classful(fixture)
    assert_equal(got, expected, "json_parse_classful simple deep-nested test case failed!");
    
    expected = new ClassfulJsonVector2(3, 4);
    fixture = @'{ "_class_": "ClassfulJsonVector2", "x": 3, "y": 4 }';
    got = json_parse_classful(fixture);
    assert_equal(got, expected, "json_parse_classful test case failed!");
    
    expected = new ClassfulJsonList("foo", new ClassfulJsonVector2(3, 4), ["bar", { baz: "qux" }, new ClassfulJsonBlank()]);
    fixture = @'{ "_class_": "ClassfulJsonList", "data": ["foo", { "_class_": "ClassfulJsonVector2", "x": 3, "y": 4 },["bar", { "baz": "qux" }, { "_class_": "ClassfulJsonBlank" }]]}';
    got = json_parse_classful(fixture);
    assert_equal(got, expected, "json_parse_classful complex test case failed!");
}
