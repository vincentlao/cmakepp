
macro(pop_back  var result)
	get_property(lst GLOBAL PROPERTY ${var})
	list(LENGTH lst len)
	math(EXPR len "${len} - 1")
	list(GET lst ${len} ${result})
	list(REMOVE_AT lst ${len})
	set_property(GLOBAL PROPERTY ${var} ${lst})
	debug_message("popback ${lst}")
endmacro()