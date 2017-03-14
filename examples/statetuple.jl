using DTMarkovChain

runs = [[(1,2),(1,1),(1,2),(2,1),(1,2),(2,2)],
  [(2,1),(1,1),(1,2),(2,2),(2,2),(1,1),(1,2),(2,1),(1,1)]]
states = [(1,1),(1,2),(2,1),(2,2)]
mc = fit(DTFiniteMarkovChain,runs,states)
