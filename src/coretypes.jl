import CategoricalArrays: AbstractCategoricalVector

abstract MarkovChain

type DTFiniteMarkovChain{A<:Any,F<:AbstractFloat,I<:Integer,
          R<:Integer} <: MarkovChain
  initial::AbstractVector{F}
  transition::AbstractMatrix{F}
  rowcounts::AbstractVector{I}
  initialcount::I
  alphabet::AbstractCategoricalVector{A,R}
  equality::Function
end
