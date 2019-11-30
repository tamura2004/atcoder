parseInt(x) = parse(Int, x)
parseMap(x::Array{SubString{String},1}) = map(parseInt, x)

function main()
    n,m,l = readline() |> split |> parseMap
    g = 10^12*ones(Int,n,n)
    for i in 1:n
        g[i,i] = 0
    end
    for i in 1:m
        a,b,c = readline() |> split |> parseMap
        g[a,b] = c
        g[b,a] = c
    end
    for k in 1:n
        for i in 1:n
            for j in 1:n
                g[i,j] = min(g[i,j],g[i,k]+g[k,j])
            end
        end
    end
    h = 10^12*ones(Int,n,n)
    for i in 1:n
        for j in 1:n
            if g[i,j] <= l
                h[i,j] = 1
            end
        end
    end
    for k in 1:n
        for i in 1:n
            for j in 1:n
                h[i,j] = min(h[i,j],h[i,k]+h[k,j])
            end
        end
    end
    q = readline() |> parseInt
    for i in 1:q
        s,t = readline() |> split |> parseMap
        println(h[s,t] < 10^11 ? h[s,t] - 1 : -1)
    end
end

main()

