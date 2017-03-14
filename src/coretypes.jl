
abstract MarkovChain

abstract MarkovChainFitParams

type DTFiniteMarkovChainMleFitParams{I<:Integer,D<:Dict} <: MarkovChainFitParams
  counts_initial::AbstractVector{I}
  counts_transition::AbstractMatrix{I}
  alphabetdict::D
end

type DTFiniteMarkovChain{
      A<:Any,F<:AbstractFloat} <: MarkovChain
  initial::AbstractVector{F}
  transition::AbstractMatrix{F}
  alphabet::AbstractVector{A}
end

type DTFiniteMarkovChainWithFit{
    FMC<:DTFiniteMarkovChain,MCFP<:MarkovChainFitParams} <: MarkovChain
  mc::FMC
  fitparams::MCFP
end
