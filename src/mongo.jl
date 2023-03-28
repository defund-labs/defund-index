using Mongoc
using DotEnv
DotEnv.config()

client = Mongoc.Client(ENV["MONGO_URL"])
database = client["orbit-alpha-1"]

function addDoc(collection_name::String, doc::Dict)
    collection  = database[collection_name]
    document = Mongoc.BSON(doc)
    result = push!(collection, document)
    return result
end