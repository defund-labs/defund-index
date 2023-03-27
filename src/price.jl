using HTTP
using JSON
using DotEnv
DotEnv.config()

function getFunds()
    res = HTTP.get(ENV["COSMOS_API"]*"/defund-labs/defund/etf/fund")
    data = res.body |> String |> JSON.parse
    return data
end

function getFund(symbol::String)
    res = HTTP.get(ENV["COSMOS_API"]*"/defund-labs/defund/etf/fund/"*symbol)
    data = res.body |> String |> JSON.parse
    return data
end

function getPrice(symbol::String)
    res = HTTP.get(ENV["COSMOS_API"]*"/defund-labs/defund/etf/fundPrice?symbol="*symbol)
    data = res.body |> String |> JSON.parse
    return data
end