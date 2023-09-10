///@func __classful_dehydrated_copy__(val, classField)
///@param {Any} value The value to try to dehydrate.
///@param {String} classField The key to indicate the class type with.
///@return {Any}
///@ignore
///@desc Recursively turn all structs contained in the given value to untyped structs marked with a class field.
function __classful_dehydrated_copy__(value, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    // Entries of structs need recursive dehydrated copies
    if (is_struct(value)) {
        var structKeys = variable_struct_get_names(value);
        var structSize = array_length(structKeys);
        var newStruct = {};
        // Recurse on each key
        for (var i = structSize-1; i >= 0; --i) {
            var structKey = structKeys[i];
            var structValue = value[$ structKey];
            if (is_struct(structValue) or is_array(structValue)) {
                newStruct[$ structKey] = __classful_dehydrated_copy__(structValue, classField);
            } else {
                newStruct[$ structKey] = structValue;
            }
        }
        // Only typed structs need to be marked
        if (instanceof(value) != "struct") {
            newStruct[$ classField] = instanceof(value);
        }
        return newStruct;
    }
    // Entries of arrays need recursive dehydrated copies
    else if (is_array(value)) {
        var arraySize = array_length(value);
        var newArray = array_create(arraySize);
        for (var i = arraySize-1; i >= 0; --i) {
            var arrayEntry = value[i];
            if (is_struct(arrayEntry) or is_array(arrayEntry)) {
                newArray[i] = __classful_dehydrated_copy__(arrayEntry, classField);
            } else {
                newArray[i] = arrayEntry;
            }
        }
        return newArray;
    }
    return value;
}

///@func __classful_rehydrate_inplace__(val, classField)
///@param {Any} value The value to try to rehydrate.
///@param {String} classField The key to indicate the class type with.
///@ignore
///@desc Recursively restore the class types of all structs in the given value using the given class field.
function __classful_rehydrate_inplace__(value, classField=CLASSFUL_JSON_DEFAULT_CLASSFIELD) {
    if (is_struct(value)) {
        // Look for type to restore
        if (variable_struct_exists(value, classField)) {
            var originalClassName = value[$ classField];
            var originalClass = static_get(asset_get_index(originalClassName));
            variable_struct_remove(value, classField);
            static_set(value, originalClass);
        }
        // Recurse on other fields
        var structKeys = variable_struct_get_names(value);
        var structSize = array_length(structKeys);
        for (var i = structSize-1; i >= 0; --i) {
            var structKey = structKeys[i];
            var structValue = value[$ structKey];
            if (is_struct(structValue) or is_array(structValue)) {
                __classful_rehydrate_inplace__(structValue, classField);
            }
        }
    }
    else if (is_array(value)) {
        // Recurse on entries
        for (var i = array_length(value)-1; i >= 0; --i) {
            var arrayValue = value[i];
            if (is_struct(arrayValue) or is_array(arrayValue)) {
                __classful_rehydrate_inplace__(arrayValue, classField);
            }
        }
    }
}
