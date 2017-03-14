module DTMarkovChain

include("coretypes.jl")
export MarkovChain,
  MarkovChainFitParams,
  DTFiniteMarkovChain,
  DTFiniteMarkovChainWithFit,
  DTFiniteMarkovChainMleFitParams

include("finite.jl")
export fit,
  fit!

end # module
