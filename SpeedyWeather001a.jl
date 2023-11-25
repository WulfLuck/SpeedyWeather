#   SpeedyWeather001a.jl         Milan Klöwer

#   https://www.youtube.com/watch?v=qgmgg_Bzgyg



import Pkg; Pkg.add("SpeedyWeather")       #; Pkg.instantiate 

#Pkg.add("SafeTestsets"); Pkg.add("Aqua")
using SpeedyWeather


#spectral_grid = SpectralGrid(trunc=31, Grid=OctaHEALPixGrid)
spectral_grid = SpectralGrid(trunc=62, Grid=OctaHEALPixGrid)


orography = EarthOrography(spectral_grid)

horizontal_diffusion = HyperDiffusion(spectral_grid, power=4, adaptive=false)
large_scale_condensation = SpeedyCondensation(spectral_grid, time_scale=2)

model = PrimitiveWetModel(; spectral_grid, orography, horizontal_diffusion, large_scale_condensation)

simulation = initialize!(model)

run!(simulation, n_days=5, output=false)

precip = simulation.diagnostic_variables.surface.precip_large_scale
plot(precip)


#=

map = randn(OctahedralGaussianGrid{Float16},4)
plot(map)

map2 = RingGrids.interpolate(FullClenshawGrid{Float32}, map)
plot(map2)          # youtube 47-ring ?

=#