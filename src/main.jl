N = parse(Int, readline())

mask(i) = 1 << ((i - 3) >> 1)

function dfs(block, a, use)
    if a > N
        return
    end

    if use == 0b111
        block(a)
    end

    for i in [3,5,7]
        dfs(block, a * 10 + i, use | mask(i))
    end
end

function main()
    ans = 0
    dfs(0, 0) do a
        ans += 1
    end
    return ans
end

println(main())

  