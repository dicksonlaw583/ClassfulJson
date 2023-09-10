# Classful JSON

## Overview

This GameMaker Studio 2023 library allows you to stringify values containing constructor-built structs into JSON, and parse JSON produced this way with the constructor-specified type intact. It also adds the ability to save and load such JSON files.

## Requirements

- GameMaker Studio 2023.6 or higher

## Installation

Get the current asset package and associated documentation from [the releases page](https://github.com/dicksonlaw583/ClassfulJson/releases). Once you download the package, extract everything to your project.

## Example

```gml
function Vector2(x, y) constructor {
    self.x = x;
    self.y = y;

    static norm = function() {
        return point_distance(0, 0, x, y);
    };

    static toString = function() {
        return $"Vector2({x}, {y})";
    };
}
```

```gml
var myVector = new Vector2(3, 4);
var myFile = working_directory + "myVector.json";

// Stringify to Classful JSON
var classfulJson = json_stringify_classful(myVector);
show_debug_message(classfulJson); //{"x":3.0,"y":4.0,"_class_":"Vector2"} or equivalent

// Parse from Classful JSON
var parsedVector = json_parse_classful(classfulJson);
show_debug_message(parsedVector); //Vector2(3, 4)

// Save the Classful JSON to a file with indentations
json_save_classful(myFile, myVector, true);

// Load the Classful JSON from a file
var loadedVector = json_load_classful(myFile);
show_debug_message(loadedVector); //Vector2(3, 4)
    
// Cleanup
file_delete(myFile);
```

## Configurations

These configurations can be changed in the script named `__CLASSFUL_JSON_CONFIGS__`.

### The Class Field

You can change the default **class field** by modifying the `CLASSFUL_JSON_DEFAULT_CLASSFIELD` macro.

Example:

```gml
#macro CLASSFUL_JSON_DEFAULT_CLASSFIELD "_"
```

### Seeding Statics

The static struct for a constructor only exists after it has been used with `new` at least once. This can be a problem when `json_load_classful` or `json_parse_classful` is used before the constructor is used with `new` for the first time, such as when loading a save file straight from the startup menu. You can force the static struct to exist ahead of time by using them with `new` here.

Example:

```gml
var CLASSFUL_JSON_STATIC_INITS = [
    new Vector2(0, 0),
];
```

## How It Works

This library works by marking structs with an additional **class field** (`"_class_"` by default) if it was constructor-built. Structs found with this additional class field receive special handling by the library to set its static back to the specified constructor-specified type.

Example of a constructor-built struct:

```
var myVector = new Vector2(3, 4);
```

Its Classful JSON would be this:

```json
{ "x": 3, "y": 4, "_class_": "Vector2" }
```

### Stringifying to JSON

When stringifying, first the library makes a deep clone of the original value, where every constructor-built struct is turned into an untyped struct with an added **class field** set to the return value of `instanceof`. This deep clone is then stringified, producing the Classful JSON.

### Parsing from JSON

When parsing, first the library parses the JSON into a value containing only untyped structs. The library then traverses the value's entire nesting structure, turning in-place any structs it encounters with a **class field** back into a constructor-built struct using `static_set`.
