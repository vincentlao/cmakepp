function(test)
  define_test_function(test_uut package_dependency_changeset)

  test_uut("{}")
  test_uut("{ A:'add' }" A)
  test_uut("{ A:'add', B:'add'}" A B)
  test_uut("{ A:'optional' }" "A optional")
  test_uut("{ A:'conflict' }" "A conflict")
  test_uut("{ A:['add',{asd:'asd'}] }" "A {asd:'asd'}")
endfunction()