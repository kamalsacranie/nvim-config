return {
    s({
        trig = "for",
        name = "For loop",
        desc = "for loop to repeat specified number of times"
    }, fmta([[
        for <> = <>
            <>
        end]], { i(1), i(2), i(3) })),
    s({
        trig = "if",
        name = "If statement",
        desc = "Execute statements if condition is true"
    }, fmta([[
        if <>
            <>
        end]], { i(1), i(2) })),
    s({
        trig = "parfor",
        name = "Parallel for loop",
        desc = "Parallel for loop (requires Parallel Computing Toolbox)"
    }, fmta([[
        parfor <> = <>
            <>
        end]], { i(1), i(2), i(3) })),
    s({
        trig = "spmd",
        name = "Execute parallel code",
        desc =
        "Execute code in parallel on workers of parallel pool (requires Parallel Computing Toolbox)"
    }, fmta([[
        spmd
            <>
        end]], { i(1) })),
    s({
        trig = "ifelse",
        name = "If-else statement",
        desc =
        "Execute some statements if condition is true, and others if statement is false"
    }, fmta([[
        if <>
            <>
        else
            <>
        end]], { i(1), i(2), i(3) })),
    s({
        name = "While Loop",
        trig = "while",
        description = "while loop to repeat when condition is true"
    }, fmta([[
            while <>
                <>
            end]], { i(1), i(2) })),
    s({
        name = "Try-Catch Statement",
        trig = "try",
        description =
        "Execute statements and catch resulting errors"
    }, fmta([[
            try
                <>
            catch <>
                <>
            end]], { i(1), i(2), i(3) })),
    s({
        name = "Switch Statement",
        trig = "switch",
        description = "Execute one of several groups of statements"
    }, fmta([[
            switch <>
                case <>
                    <>
                otherwise
                    <>
            end]], { i(1), i(2), i(3), i(4) })),
    s({
        name = "Function Definition",
        trig = "func",
        description = "Declare function name, inputs, and outputs"
    }, fmta([[
            function <> = <>(<>)
                <>
            end]], { i(1, "output"), i(2, "name"), i(3, "input"), i(4) })),
    s({
        name = "Class Definition",
        trig = "classdef",
        description = "Defines a class"
    }, fmta([[
            classdef <>
                properties
                    <>
                end

                methods
                    function obj = <>(<>)
                        <>
                    end
                end
            end]], { i(1, "ClassName"), i(2, "Property1"), i(3, "name"), i(4, "inputArgs"), i(5) })),
}
