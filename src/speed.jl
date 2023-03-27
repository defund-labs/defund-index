using HTTP
using JSON

function getCurrentBlock()
    res = HTTP.get(ENV["COSMOS_API"]*"/cosmos/base/tendermint/v1beta1/blocks/latest")
    data = res.body |> String |> JSON.parse
    return data
end

function getBlock(block::Int64)
    res = HTTP.get(ENV["COSMOS_API"]*"/cosmos/base/tendermint/v1beta1/blocks/$block")
    data = res.body |> String |> JSON.parse
    return data
end

function getBlocks(from::Int64, to::Int64)
    blocks = []
    @sync begin
        Threads.@threads for i in from:to
            @async begin
                push!(blocks, getBlock(i))
            end
        end
    end
    return blocks
end