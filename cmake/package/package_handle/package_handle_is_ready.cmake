## 
## checks if every dependencies all_dependencies_materialized are set
##
function(package_handle_is_ready package_handle)
  map_tryget(${package_handle} materialization_descriptor)
  ans(is_materialized)
  if(NOT is_materialized)
    return(false)
  endif()
  map_tryget(${package_handle} dependencies)
  map_flatten(${__ans})
  ans(dependencies)
  set(all_dependencies_materialized true)
  foreach(dependency ${dependencies})
    map_get_map(${dependency} dependency_descriptor)
    ans(dependency_dependency_descriptor)
    map_tryget(${dependency_dependency_descriptor} is_ready)
    ans(dependency_all_dependencies_materialized)
    if(NOT dependency_all_dependencies_materialized)
      set(all_dependencies_materialized false)
      break()
    endif()
  endforeach()
  return_ref(all_dependencies_materialized)
endfunction()