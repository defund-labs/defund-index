include("price.jl")
include("speed.jl")
include("validator.jl")
include("mongo.jl")

blocks = getBlocks(1000000, 1100000)
@sync begin
    for block in blocks
        @async begin
            height = block["header"]["height"]
            block["_id"] = height
            addDoc("blocks", block)
            println("Added $height")
        end
    end
end