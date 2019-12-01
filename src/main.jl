r() = [parse(Int,x) for x in readline() |> split]

function main()
    N,W = r()
    DP = zeros(Int,N+1,W+1)
    for i in 2:N+1
        w,v = r()
        for j in 1:W
            if j >= w
                DP[i,j+1] = max(DP[i-1,j+1], DP[i-1,j+1-w] + v)
            else
                DP[i,j+1] = DP[i-1,j+1]
            end
        end
        # println("DP = $DP")
    end
    println(maximum(DP))
end

main()

