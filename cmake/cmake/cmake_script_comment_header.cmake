
  function(cmake_script_comment_header content)
    set(args ${ARGN})
    list_extract_flag(args --depth)
    ans(expected_depth)
    if("${expected_depth}_" STREQUAL "")
      set(expected_depth 1)
    endif()

    string_repeat( "#" "${expected_depth}")
    ans(expected_depth)
    cmake_script_parse("${content}" --comment-header --ignore-newlines)
    ans(lines)
    set(markdown)
    foreach(line ${lines})
      map_tryget(${line} type)
      ans(type)
      
      if("${type}" STREQUAL "comment")
        map_tryget(${line} comment_depth)
        ans(depth)
        if("${depth}" STREQUAL "${expected_depth}")
          map_tryget("${line}" comment)
          ans(comment)
          set(markdown "${markdown}${comment}\n")
        else()
          break()
        endif()
      endif()
    endforeach()
    
    return_ref(markdown)  
  endfunction()
