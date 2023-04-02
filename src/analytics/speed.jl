using Mongoc
using DotEnv
using TimesDates, TimeZones, Dates
using Statistics
DotEnv.config()

ENV["SSL_CERT_DIR"] = "/etc/ssl/certs/"

client = Mongoc.Client(ENV["MONGO_URL"])
database = client["orbit-alpha-1"]
collection = database["blocks"]
docs = Mongoc.find(collection)
items = map(item -> Dict("height" => parse(Float64, item["header"]["height"]), "time" => TimeDate(String(split(item["header"]["time"], "Z")[1]))), docs)
items = sort!(items, by = x -> x["height"])
block_times = []
Threads.@threads for i in 1:length(items)
    if i == length(items)
        continue
    end
    current = items[i]
    next = items[i+1]
    height = next["height"]
    diff = next["time"] - current["time"]
    println("Block Speed for $height: $diff")
    push!(block_times, Float64(Dates.value(diff))/Float64(1000000))
end

println("Average: ", mean(block_times))
println("Std: ", std(block_times))
println("Median: ", median(block_times))