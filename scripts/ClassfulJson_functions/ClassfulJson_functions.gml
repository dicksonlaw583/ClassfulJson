///@func json_stringify_classful(value, prettify, classField)
///@param {Any} value  The value to encode.
///@param {Bool} prettify  Whether the resulting JSON string should be prettified. Default: false
///@param {String} classField  The key to indicate the class type with. Default: The value set for CLASSFUL_JSON_DEFAULT_CLASSFIELD
///@return {String}
///@desc Encode the given value as JSON, marking constructor-built structs using the given field to indicate its class type.
function json_stringify_classful(value, prettify=false, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    // Structs and arrays need recursive handling
    if (is_struct(value) or is_array(value)) {
        var dehydratedVal = __classful_dehydrated_copy__(value, classField);
        return json_stringify(dehydratedVal, prettify);
    }
    // Other types can be encoded as-is
    return json_stringify(value, prettify);
}

///@func json_save_classful(filename, value, classField)
///@param {String} filename  The file to save into.
///@param {Any} value  The value to encode.
///@param {Bool} prettify  Whether the resulting JSON string should be prettified. Default: false
///@param {String} classField  The key to indicate the class type with. Default: The value set for CLASSFUL_JSON_DEFAULT_CLASSFIELD
///@desc Save the given value as a JSON file, marking constructor-built structs using the given field to indicate its class type.
function json_save_classful(filename, value, prettify=false, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    var result = json_stringify_classful(value, prettify, classField);
    var buffer = buffer_create(string_byte_length(result), buffer_fixed, 1);
    buffer_write(buffer, buffer_text, result);
    buffer_save(buffer, filename);
    buffer_delete(buffer);
}

///@func json_parse_classful(str, classField)
///@param {String} str  The string to encrypt
///@param {String} classField  The key to indicate the class type with. Default: The value set for CLASSFUL_JSON_DEFAULT_CLASSFIELD
///@return {Any}
///@desc Decode the given JSON string, restoring types of constructor-built structs using the given field indicating class type.
function json_parse_classful(str, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    var result = json_parse(str);
    if (is_struct(result) or is_array(result)) {
        __classful_rehydrate_inplace__(result, classField);
    }
    return result;
}

///@func json_load_classful(filename, classField)
///@param {String} filename  The file to load from.
///@param {String} classField  The key to indicate the class type with. Default: The value set for CLASSFUL_JSON_DEFAULT_CLASSFIELD
///@return {Any}
///@desc Load the given JSON file, restoring types of constructor-built structs using the given field indicating class type.
function json_load_classful(filename, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    var buffer = buffer_load(filename);
    var fileContent = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
    var result = json_parse_classful(fileContent, classField);
    return result;
}
