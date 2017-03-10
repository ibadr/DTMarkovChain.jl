using DTMarkovChain
using CategoricalArrays

mc = DTMarkovChain.DTFiniteMarkovChain(Vector{Float64}(),Matrix{Float64}(),
  Vector{UInt64}(),UInt64(0),CategoricalArray([(1,1),(1,2),(2,1),(2,2)]),==)

estimatemodel!(mc,[[(1,2),(1,1),(1,2),(2,1),(1,2),(2,2)],
  [(2,1),(1,1),(1,2),(2,2),(2,2),(1,1),(1,2),(2,1),(1,1)]])
