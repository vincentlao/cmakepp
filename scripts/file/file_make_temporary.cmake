function(file_make_temporary result content)
 random_file(rnd "${cutil_temp_dir}/file_make_temporary_{{id}}.tmp")
 file(WRITE ${rnd} "${content}")
 return_value(${rnd})
endfunction()