using HTTP
using JSON

function getValidators()
    validators = []
    limit = 1000
    res = HTTP.get(ENV["COSMOS_API"]*"/cosmos/staking/v1beta1/validators?pagination.limit=$limit")
    data = res.body |> String |> JSON.parse
    validators = data["validators"]
    while isnothing(data["pagination"]["next_key"]) == false
        limit = limit+limit
        key = HTTP.escapeuri(data["pagination"]["next_key"])
        res = HTTP.get(ENV["COSMOS_API"]*"/cosmos/staking/v1beta1/validators?pagination.limit=$limit&pagination.key=$key")
        data = res.body |> String |> JSON.parse
        validators = vcat(validators, data["validators"])
    end
    return validators
end