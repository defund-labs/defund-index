include("price.jl")
include("speed.jl")
include("validator.jl")
using Comonicon

@cast mycmd1(arg; option="Sam") = println("cmd1: arg=", arg, "option=", option)
@cast mycmd2(arg; option="Sam") = println("cmd2: arg=", arg, "option=", option)

"""
a module
"""
module Cmd3

using Comonicon

@cast mycmd4(arg) = println("cmd4: arg=", arg)

end # module

@cast Cmd3

"""
Defund Indexer CLI
"""
@main function start(arg; option="Sam", flag::Bool=false)
    @show arg
    @show option
    @show flag
end