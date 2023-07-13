using Plots
using DataFrames, CSV
using LaTeXStrings
using Plots.PlotMeasures
using Colors

CSV.read("/home/sebastian/thesis/codes/julia/thesis/couplings.csv", DataFrame)

data = CSV.read("/home/sebastian/thesis/codes/julia/thesis/couplings.csv",DataFrame)
data_higgs = CSV.read("/home/sebastian/thesis/codes/python/datoshgg.csv",DataFrame)

function plotsc(x,y)
    fig = scatter(x,y,
        ms=2,size=(750,500),
        dpi=400,
        ylabelfontsize = 16,
        xlabelfontsize = 16,
        legend = :none,
        # tickfont = font(9,"Computer Modern"),
        left_margin = 3mm,
        bottom_margin = 3mm,
        right_margin = 3mm,
        titlefont = font(15, "Computer Modern"),
        grid = false,
        yscale=:log10,
        # marker_z = data[!,"mn1"] ./ 1e11,
        # color = :jet,
        markercolor = :dodgerblue4,
        cscale =log10,
        markerstrokewidth = 0.01,
        framestyle = :box,
        # colorbar = true,
        # colorbar_title = L"M_{\eta_1} (\textrm{GeV})",
        # colorbar_titlefontsize = 15
    )
    return fig
end

plot = plotsc(data[!,"mn1"] ./ 1e10, data[!,"b_22"])
xlabel!(L"m_{\eta_1} (\textrm{GeV})")
ylabel!(L"m_{\eta_2} / m_{\eta_1}")

# colorbar(plot1, pltHeat, scale = log10,size=(1700,500))

savefig(plot,"fig_new_mfermion2.png")

scatter(data[!,"mk2"] ./ 1e10,data_higgs[!,"0"],
        ms=2.5, size = (750,500),
        dpi=400,
        ylabelfontsize = 16,
        xlabelfontsize = 16,
        left_margin = 3mm,
        bottom_margin = 3mm,
        right_margin = 3mm,
        framestyle=:box,
        legend=:none,
        markerstrokewidth = 0.01,
        markercolor = :dodgerblue4,
        grid = false,
        # tickfont = font(9,"Computer Modern")
        )
    
xlabel!(L"m_{\kappa_2} (\textrm{GeV})")
ylabel!(L"R_{\gamma \gamma}")
hline!([1.12- 3*0.09],c=:black,linestyle=:dash)
hline!([1.12],c=:black)
hline!([1.12+ 3*0.09],c=:black,linestyle=:dash)
ylims!(0.40,1.2)

current()

savefig(current(),"higgs6.png")

## las relaciones entre las masas se conservan 
## los valores para los acoples estan, en general, mas restringidos 
## se reduce el numero de valores permitidos por la fisica de neutrinos (no mucho)
## se tomaron valores para las masas de los fermiones de aprox 105-205 GeV 