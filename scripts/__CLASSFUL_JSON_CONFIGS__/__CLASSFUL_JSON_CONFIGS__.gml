/*
Set the default class field here.
*/

#macro CLASSFUL_JSON_DEFAULT_CLASSFIELD "_class_"

/*
Seed the static structs for constructors here by using them with "new".
  
You need to do this for every type that you load with json_parse_classful
or json_load_classful, if these loading calls may happen before the first
time the constructor is used with "new". An example of this would be when
loading an in-game inventory class straight from the startup menu.
  
Example:
  
var CLASSFUL_JSON_STATIC_INITS = [
    new Inventory(),
    new Item(),
];  
*/

var CLASSFUL_JSON_STATIC_INITS = [
];
