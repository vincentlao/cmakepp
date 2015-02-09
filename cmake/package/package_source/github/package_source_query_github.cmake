## package_source_query_github([--package-handle])->
##
##
## "" => null 
## <github user> => <github user>/*
## <github user>/* => repo list
## <github user>/<repository> => <github user>/<repository>/branches/<default branch>?hash=<commit sha>
## <github user>/<repository>/* => <github user>/<repository>/(branches|tags)/<name>?hash=<commit sha> ...
## <github user>/<repository>/<ref name> => <github user>/<repository>/branches/<ref name>?hash=<commit sha>
## <github user>/<repository>/<ref type>/* => <github user>/<repository>/<ref type>/<ref name>?hash=<commit sha>
## <github user>/<repository>/<ref type>/<ref => <github user>/<repository>/<ref type>/<ref name>?hash=<commit sha>
function(package_source_query_github uri)
  set(args ${ARGN})

  list_extract_flag(args --package-handle)
  ans(return_package_handle)


  ## parse uri and extract the two first segments 
  uri("${uri}")
  ans(uri)


  assign(scheme = uri.scheme)
  if(NOT "${scheme}_" STREQUAL "_" AND NOT "${scheme}" STREQUAL "github")
    return()
  endif()


  assign(segments = uri.normalized_segments)
  list_extract(segments user repo ref_type ref)
  
  set(repo_query)
  if("${repo}_" STREQUAL "*_")
    set(repo)
    set(repo_query *)
  endif()

  set(package_handles)

  if(user AND repo AND ref_type)
    if(NOT "${ref_type}" MATCHES "\\*|branches|tags" )
      set(ref_query ${ref_type})
      set(ref_type *)
    else()
      set(ref_query "*")
    endif()
    github_remote_refs("${user}" "${repo}" "${ref_type}" "${ref_query}")
    ans(refs)
    foreach(current_ref ${refs})
      map_format("github:${user}/${repo}/{current_ref.ref_type}/{current_ref.ref}?hash={current_ref.commit}")
      ans_append(package_handles)
    endforeach()
  elseif(user AND repo)
    github_repository("${user}" "${repo}")
    ans(repository)
    assign(default_branch = repository.default_branch)
    github_remote_refs("${user}" "${repo}" "branches" "${default_branch}")
    ans(ref)
    map_format("github:{repository.full_name}/branches/{repository.default_branch}?hash={ref.commit}")
    ans(package_handles)
  elseif(user)
    ## only  user results in non unique ids which have to be quried again
    github_repository_list("${user}")
    ans(repositories)
    list_select(repositories "(repo)-> return('github:{repo.full_name}')")
    ans(package_handles)
  else()
    ## no user (not queried) too many results
  endif()



    if(return_package_handle)
      set(uris ${package_handles})
      set(package_handles)
      foreach(github_url ${uris})
        set(package_handle)
        assign(!package_handle.uri = github_url)
        assign(!package_handle.query_uri = uri.uri)
        list(APPEND package_handles ${package_handle})
      endforeach()
      return_ref(package_handles)
    endif()
    return_ref(package_handles)

endfunction()

