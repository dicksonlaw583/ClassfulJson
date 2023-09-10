///@func classful_json_test_files()
///@desc Test Classful JSON file operations.
function classful_json_test_files() {
    var fixture, got, expected;
    var loadFilename = working_directory + "ClassfulJson/loadtest.json";
    var loadCustomFilename = working_directory + "ClassfulJson/loadtest_custom.json";
    var saveFilename = working_directory + "ClassfulJson/savetest.json";
    
    expected = new ClassfulJsonList("foo", new ClassfulJsonVector2(3, 4), ["bar", { baz: "qux" }, new ClassfulJsonBlank()]);
    got = json_load_classful(loadFilename);
    assert_equal(got, expected, "json_load_classful test case failed!");
    
    expected = new ClassfulJsonList("foo", new ClassfulJsonVector2(3, 4), ["bar", { baz: "qux" }, new ClassfulJsonBlank()]);
    got = json_load_classful(loadCustomFilename, "klass");
    assert_equal(got, expected, "json_load_classful custom test case failed!");
    
    fixture = new ClassfulJsonList("FOO1", new ClassfulJsonVector2(3, 4), ["BAR1", { baz: "QUX1" }, new ClassfulJsonBlank()]);
    json_save_classful(saveFilename, fixture);
    got = json_load_classful(saveFilename);
    assert_equal(got, fixture, "json_save_classful simple roundtrip test case failed!");
    
    fixture = new ClassfulJsonList("FOO2", new ClassfulJsonVector2(3, 4), ["BAR2", { baz: "QUX2" }, new ClassfulJsonBlank()]);
    json_save_classful(saveFilename, fixture, true);
    got = json_load_classful(saveFilename);
    assert_equal(got, fixture, "json_save_classful simple roundtrip prettified test case failed!");
    
    fixture = new ClassfulJsonList("FOO3", new ClassfulJsonVector2(3, 4), ["BAR3", { baz: "QUX3" }, new ClassfulJsonBlank()]);
    json_save_classful(saveFilename, fixture, false, "klass");
    got = json_load_classful(saveFilename, "klass");
    assert_equal(got, fixture, "json_save_classful simple roundtrip custom class field test case failed!");
    
    // Cleanup
    json_save_classful(saveFilename, {});
}
