## copies the contents of source_dir to target_dir
function(cp_dir source_dir target_dir)
  path_qualify(source_dir)
  path_qualify(target_dir)
  cmake(-E copy_directory "${source_dir}" "${target_dir}" --exit-code)
  ans(error)
  if(error)
    message(FATAL_ERROR "failed to copy contents of '${source_dir}' to '${target_dir}' this often happens when file names are too long ")
  endif()
  return_ref(target_dir)
endfunction()
