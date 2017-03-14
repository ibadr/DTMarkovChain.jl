
import StatsBase: StatsBase,fit, fit!

function _fit!{A<:Any}(
  mchain::DTFiniteMarkovChainWithFit,runs::Vector{Vector{A}})
  alphbt = mchain.mc.alphabet
  sz = length(alphbt)
  I = eltype(mchain.fitparams.counts_initial)
  fill!(mchain.fitparams.counts_initial,zero(I))
  fill!(mchain.fitparams.counts_transition,zero(I))
  initial = mchain.fitparams.counts_initial
  transition = mchain.fitparams.counts_transition
  @inbounds for r in runs
    k = _retrieveindex(r[1],alphbt)
    initial[k] = initial[k] + 1
    for n in 1:endof(r)-1
      k1 = _retrieveindex(r[n],alphbt)
      k2 = _retrieveindex(r[n+1],alphbt)
      transition[k1,k2] = transition[k1,k2] + 1
    end
  end
  initialcount = sum(initial)
  mchain.mc.initial[:] = initial ./ initialcount
  rowcounts = sum(transition,2)[:,1]
  mchain.mc.transition[:] = broadcast(/,transition,rowcounts)
  return mchain
end

StatsBase.fit!{A<:Any}(
  mchain::DTFiniteMarkovChainWithFit,runs::Vector{Vector{A}}) = _fit!(
    mchain,runs)

function StatsBase.fit{A<:Any}(::Type{DTFiniteMarkovChain},
    runs::Vector{Vector{A}},states::Vector{A})
  sz = length(states)
  fitparams = DTFiniteMarkovChainMleFitParams(
    Vector{UInt64}(sz),Matrix{UInt64}(sz,sz),Dict{A,Int}())
  mc = DTFiniteMarkovChain(Vector{Float64}(sz),
    Matrix{Float64}(sz,sz),states)
  mchain = DTFiniteMarkovChainWithFit(mc,fitparams)
  return fit!(mchain,runs)
end

function _retrieveindex(v,alphabet)
  k = 0
  for i in eachindex(alphabet)
    if alphabet[i]==v
      k = i
      break
    end
  end
  return k
end
