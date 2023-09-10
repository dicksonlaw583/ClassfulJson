///@class ClassfulJsonBlank()
///@desc A blank class for testing Classful JSON.
function ClassfulJsonBlank() constructor {
    /* This is intentionally left blank. */
}

///@class ClassfulJsonVector2(x, y)
///@param {Real} x 
///@param {Real} y 
///@desc A 2D vector class for testing Classful JSON.
function ClassfulJsonVector2(x, y) constructor {
    #region Constructor properties
    self.x = x;
    self.y = y;
    #endregion
    
    ///@func norm()
    ///@return {Real}
    ///@desc Return the length of the vector.
    static norm = function() {
        return point_distance(0, 0, x, y);
    };
    
    ///@func toString()
    ///@return {String}
    ///@desc Return a string representation of this vector.
    static toString = function() {
        return $"Vector2({x}, {y})";
    };
}

///@class ClassfulJsonList()
///@desc A list class for testing Classful JSON.
function ClassfulJsonList() constructor {
    #region Constructor properties
    data = array_create(argument_count);
    for (var i = argument_count-1; i >= 0; --i) {
        data[i] = argument[i];
    }
    #endregion
    
    ///@func size()
    ///@return {Real}
    ///@desc Return the size of the list.
    static size = function() {
        return array_length(data);
    };
    
    ///@func toString()
    ///@return {String}
    ///@desc Return a string representation of this list.
    static toString = function() {
        return $"List({string_join_ext(", ", data)})";
    };
}