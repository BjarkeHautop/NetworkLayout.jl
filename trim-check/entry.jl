module TrimCheck

using NetworkLayout
using Random: MersenneTwister

# Exercises the layouts that are trim-compatible: Spring, Stress, SFDP,
# Spectral, Shell and SquareGrid. The random layouts need an explicit `rng`:
# the default, `DEFAULT_RNG[](seed)`, constructs a type only known at run time.

function _adj()
    # Path, a triangle and an isolated vertex.
    A = zeros(Float64, 7, 7)
    for (i, j) in ((1, 2), (2, 3), (4, 5), (5, 6), (4, 6))
        A[i, j] = A[j, i] = 1.0
    end
    return A
end

function _check_spring()
    A = _adj()
    Spring(rng = MersenneTwister(1))(A)
    spring(A; rng = MersenneTwister(1))
    spring(A; C = 1.5, iterations = 50, initialtemp = 1.0, rng = MersenneTwister(2))
    spring(A; dim = 3, Ptype = Float32, rng = MersenneTwister(1))
    return nothing
end

function _check_sfdp()
    A = _adj()
    SFDP(rng = MersenneTwister(1))(A)
    sfdp(A; tol = 0.5, C = 0.3, K = 2.0, iterations = 50, rng = MersenneTwister(2))
    return nothing
end

function _check_stress()
    A = _adj()
    Stress(rng = MersenneTwister(1))(A)
    stress(A; iterations = 100, reltols = 1e-4, rng = MersenneTwister(2))
    stress(A; dim = 3, rng = MersenneTwister(1))
    return nothing
end

function _check_spectral()
    A = _adj()
    Spectral()(A)
    spectral(A; dim = 2)
    return nothing
end

function _check_shell()
    A = _adj()
    Shell()(A)
    shell(A; nlist = [[1, 2]])
    return nothing
end

function _check_squaregrid()
    A = _adj()
    SquareGrid()(A)
    squaregrid(A; cols = 3, skip = [(1, 2)])
    return nothing
end

Base.@ccallable function trim_check_run()::Cint
    _check_spring()
    _check_sfdp()
    _check_stress()
    _check_spectral()
    _check_shell()
    _check_squaregrid()
    return Cint(0)
end

end # module
