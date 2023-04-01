include("price.jl")
include("speed.jl")
include("validator.jl")
include("mongo.jl")

blocks = getBlocks(1010000, 1030000)
@sync begin
    for block in blocks
        height = block["header"]["height"]
        @async begin
            block["_id"] = height
            addDoc("blocks", block)
        end
        println("Added $height")
    end
end