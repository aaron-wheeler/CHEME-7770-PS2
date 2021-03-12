function calculate_transcriptional_control_array(t::Float64,x::Array{Float64,1}, problem::Dict{String,Any})::Float64

    # initialize -
    u_variable = 0.0
    
    # alias elements of the species vector -
    mRNA = x[1]
    G = x[2]
    σ70 = x[3]

    # get stuff from the problem dictionary -
    E1 = problem["E1"] #kJ/mol 
    E2 = problem["E2"] #kJ/mol 
    R = problem["ideal_gas_constant_R"] #kJ/mol-K  
    T_K = problem["temperature_K"] #K 
    KD = problem["inducer_dissociation_constant"] #nM 
    n = problem["inducer_cooperativity_parameter"] #dimensionless 
    #k = problem["boltzmann_factor"] #kJ/K  

    # TODO: write u-varible function here 
    #u_variable = (W1 + W2*fi)/(1 + W1 + W2*fi)
    #W1 = exp(-E1/(k*T_K))
    #W2 = exp(-E2/(k*T_K))
    #fi = (I^n) / ((KD^n) + (I^n))
    u_variable = (exp(-E1/(R*T_K)) + exp(-E2/(R*T_K)) * ((σ70^n) / ((KD^n) + (σ70^n)))) / (1 + exp(-E1/(R*T_K)) + exp(-E2/(R*T_K)) * ((σ70^n) / ((KD^n) + (σ70^n))))

    # return -
    return u_variable
end