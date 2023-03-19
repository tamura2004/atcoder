a = [10,20,30]
pp! a.bsearch_index(&.> 0)
pp! a.bsearch_index(&.> 10)
pp! a.bsearch_index(&.> 20)
pp! a.bsearch_index(&.> 30)