using CategoricalArrays

function estimatemodel!{A<:Any,F<:AbstractFloat,I<:Integer,R<:Integer}(
  mc::DTFiniteMarkovChain{A,F,I,R},runs::Vector{Vector{A}})
  alphbt = levels(mc.alphabet)
  sz = length(alphbt)
  initial = zeros(I,sz)
  transition = zeros(I,sz,sz)

  @inbounds for r in runs
    l = r[1]
    k = _retrieveindex(l,alphbt,mc.equality)
    initial[k] = initial[k] + 1
    for n in 1:endof(r)-1
      k1 = _retrieveindex(r[n],alphbt,mc.equality)
      k2 = _retrieveindex(r[n+1],alphbt,mc.equality)
      transition[k1,k2] = transition[k1,k2] + 1
    end
  end
  mc.initialcount = sum(initial)
  mc.initial = initial ./ mc.initialcount
  mc.rowcounts = sum(transition,2)[:,1]
  mc.transition = broadcast(/,transition,mc.rowcounts)
  return mc
end

function _retrieveindex(l,alphabet,equality::Function)
  k = 0
  for i in eachindex(alphabet)
    if equality(alphabet[i],l)
      k = i
      break
    end
  end
  return k
end
