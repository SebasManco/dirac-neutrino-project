using Random
using DataFrames
using Statistics
using CSV
using Tables
using Plots 

# Define the numerical parameters ---------------------------------------------------------------------------
function couplings()
    mass_range1 = range(1e10,6e10,1000)
    mass_range2 = range(1e11,1e13,1000)
    # couplings_range = range(-1e-3,1e-3,length=10000)
    fermion_mass = range(4e11,2e12,10000)

    range(-1,-1e-3,1000)
    rand(range(-1e-1,-1e-3,10000))

    # Mass eigenvalues, m_1 = 0 and normal ordering 
    m_2 = 0.0087
    m_3 = 0.048

    # mixing angles
    α = 0.01
    δ = 0.01

    num_values = 2000000 # number of ierations for the method 
    lower_limit = 1e-8 # lower-limit value for the couplings

    # Define the ranges for the PMNS matrix 
    U_e1 = range(0.801,0.845,length=100)
    U_e2 = range(0.513,0.579,length=100)
    U_e3 = range(0.143,0.156,length=100)

    U_u1 = range(0.234,0.500,length=100)
    U_u2 = range(0.471,0.689,length=100)
    U_u3 = range(0.637,0.776,length=100)

    U_t1 = range(0.271,0.525,length=100)
    U_t2 = range(0.477,0.694,length=100)
    U_t3 = range(0.613,0.756,length=100)

    # Functions -------------------------------------------------------------------------------------------------
    B0(m1,m2,mp) = (m1^2/(m1^2 - mp^2))*log(m1^2 / mp^2) - (m2^2/(m2^2 - mp^2)) * log(m2^2/mp^2) # B0() function 

    # lambda function 
    Λ(mn1,mn2,mk1,mk2,mp) = (1/16*π^2)*mp*( (cos(α)*sin(α)/2)*(B0(mn1,mn2,mp)) + sin(δ)*cos(δ)*B0(mk1,mk2,mp) )

    # select a random number between two ranges (for the couplings)
    function split_range_rand()
        range_1 = range(-1e-2,-1e-4,length=1000)
        range_2 = range(1e-4,1e-2,length=1000)
        var = rand(1:2)

        # return var
        if var == 1
            return rand(range_1)
        elseif var == 2
            return rand(range_2)
        end
    end
    # -----------------------------------------------------------------------------------------------------------

    function sampling(lower_limit::Float64)
        a_t2 = split_range_rand()
        a_u2 = split_range_rand()
        a_u1 = split_range_rand()
        a_t1 = split_range_rand()

        m_phi1 = rand(fermion_mass)
        m_phi2 = m_phi1 + 1e10 

        mn1 = rand(mass_range2) 
        mn2 = rand(mass_range2) 
        mk1 = rand(mass_range2) 
        mk2 = rand(mass_range2)

        Λ1 = Λ(mn1,mn2,mk1,mk2,m_phi1)
        Λ2 = Λ(mn1,mn2,mk1,mk2,m_phi2)

        b_21 = (m_2/Λ1)*( (rand(U_u2)*a_t2 - rand(U_t2)*a_u2) / (a_t2*a_u1 - a_t1*a_u2) )
        b_31 = (m_3/Λ1)*( (rand(U_u3)*a_t2 - rand(U_t3)*a_u2) / (a_t2*a_u1 - a_t1*a_u2) )
        
        b_22 = (m_2/Λ2)*( (rand(U_u2)*a_t1 - rand(U_t2)*a_u1) / (a_u2*a_t1 - a_u1*a_t2) )
        b_32 = (m_3/Λ2)*( (rand(U_u3)*a_t1 - rand(U_t3)*a_u1) / (a_u2*a_t1 - a_u1*a_t2) )

        if (b_21 >= lower_limit) && (b_31 >= lower_limit) && (b_22 >= lower_limit) && (b_32 >= lower_limit)
            return [b_21,b_31,b_22,b_32,mn1,mn2,mk1,mk2,m_phi1,m_phi2]
        else
            return missing
        end
    end

    # -----------------------------------------------------------------------------------------------------------
    values = collect(skipmissing([sampling(lower_limit) for i in 1:num_values]))
    return Matrix(transpose(hcat(values...)))
end

values = couplings()

# plot the histograms 
function hist_plot(values)
    replace!(values,Inf => NaN)
    replace!(values1,NaN=>10^-10)
    
    return histogram(values[1:500],
                    legend=:none,
                    dpi=300,
                    title="valores para los acoples")
end

hist_plot(values[:,1])

# Export the data 
data = DataFrame(values, [:b_21,:b_31,:b_22,:b_32,:mn1,:mn2,:mk1,:mk2,:m_phi1,:m_phi2]) # create a DataFrame with the values for the couplings
CSV.write("/home/sebastian/thesis/codes/julia/thesis/couplings.csv",data)    # export to CSV
