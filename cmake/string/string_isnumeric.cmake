 function(string_isnumeric str)
    if("_${str}" MATCHES "^_[0-9]+$")
      return(true)
    endif()
      return(false)
 endfunction()