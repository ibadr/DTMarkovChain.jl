module DTMarkovChain

include("coretypes.jl")
export MarkovChain,
  DTFiniteMarkovChain

include("finite.jl")
export estimatemodel!

end # module
