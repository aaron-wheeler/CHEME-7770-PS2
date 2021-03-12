function generate_problem_dictionary(path_to_parameters_file::String)::Dict{String,Any}

    # initialize -
    problem_dictionary = Dict{String,Any}()

    try

        # load the TOML parameters file -
        toml_dictionary = TOML.parsefile(path_to_parameters_file)["biophysical_constants"]

        # setup the initial condition array -
        initial_condition_array = [
            0.0 ;   # 1 mRNA
            5.0 ;   # TODO: gene concentration goes here - units: nM
            0.0 ;   # 3 I = we'll fill this in the execute script 
        ]


        # TODO: calculate the mRNA_degradation_constant 
        #mRNA_degradation_constant = 3.75 # *bounded_modifier? units: 1/hr
        mRNA_degradation_constant = log(2) / 0.225 

        # TODO: VMAX for transcription -
        # VMAX = RNAPII_concentration*(transcription_elongation_rate/gene_length_in_nt)
        VMAX = 67.5 * (75600.0 / 690.0) # nM*(nt/hr)*(1/nt) = nM/hr

        # TODO: Stuff that I'm forgetting?
        #microstate_1_weight
        #microstate_2_weight

        # --- PUT STUFF INTO problem_dictionary ---- 
        problem_dictionary["transcription_time_constant"] = toml_dictionary["transcription_time_constant"]
        problem_dictionary["transcription_saturation_constant"] = toml_dictionary["transcription_saturation_constant"]
        problem_dictionary["E1"] = toml_dictionary["energy_promoter_state_1"]
        problem_dictionary["E2"] = toml_dictionary["energy_promoter_state_2"]
        problem_dictionary["inducer_dissociation_constant"] = toml_dictionary["inducer_dissociation_constant"]
        problem_dictionary["ideal_gas_constant_R"] = 0.008314 # kJ/mol-K
        problem_dictionary["temperature_K"] = (273.15+37)
        problem_dictionary["initial_condition_array"] = initial_condition_array
        
        problem_dictionary["RNAPII_concentration"] = toml_dictionary["RNAPII_concentration"]
        problem_dictionary["transcription_elongation_rate"] = toml_dictionary["transcription_elongation_rate"]
        problem_dictionary["gene_length_in_nt"] = toml_dictionary["gene_length_in_nt"]
        problem_dictionary["maximum_transcription_velocity"] = VMAX
        problem_dictionary["mRNA_degradation_constant"] = mRNA_degradation_constant
        problem_dictionary["inducer_cooperativity_parameter"] = toml_dictionary["inducer_cooperativity_parameter"]
        #problem_dictionary["microstate_1_weight"] = 
        #problem_dictionary["boltzmann_factor"] = 1.381*10^(-26) # kJ/K


    

        # return -
        return problem_dictionary
    catch error
        throw(error)
    end
end