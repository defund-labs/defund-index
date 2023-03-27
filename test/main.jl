using Test
using DotEnv
DotEnv.config()
include("../src/price.jl")
include("../src/speed.jl")
include("../src/validator.jl")

@testset "Environment" begin
    @test typeof(ENV["TENDERMINT_RPC"]) == String
    @test typeof(ENV["COSMOS_API"]) == String
end

@testset "Price" begin
    @test length(getFunds()["fund"]) > 0
    @test getFund("IBC3")["fund"]["symbol"] == "IBC3"
    @test getPrice("IBC3")["price"]["symbol"] == "IBC3"
end

@testset "Speed" begin
    @test getCurrentBlock()["block"]["header"]["chain_id"] == "orbit-alpha-1"
    @test getBlock(1000000)["block"]["header"]["chain_id"] == "orbit-alpha-1"
    @test length(getBlocks(1000000, 1000002)) > 0
end

@testset "Validator" begin
    @test length(getValidators()) > 0
end