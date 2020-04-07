using ForwardDiff
using Plots

f(x) = 0.05x^3 - 1.2x + 5
range = -8.0:0.01:8
p = plot(
    range,
    f.(range),
    legend=false,
    framestyle=:origin
)

x = -3
xᵢ = []
yᵢ = []

for i in 1:11
    if i == 1
        push!(xᵢ, x)
        push!(yᵢ, f(x))
    else
        global x = x - (f(x) / ForwardDiff.derivative(f, x))
        push!(xᵢ, x)
        push!(yᵢ, f(x))
    end
end

anim = @animate for i in 1:length(xᵢ)
    p = plot(
        range,
        f.(range),
        legend=false,
        title="Iteration $(i-1), x = $(round(xᵢ[i], digits=2)), y = $(round(yᵢ[i], digits=2))",
        framestyle=:origin
    )
    scatter!([xᵢ[i]], [yᵢ[i]])
end

gif(anim, "Newton-Raphson3.gif", fps=0.5)