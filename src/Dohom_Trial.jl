##===========================
##
## Project WENexH_Trial
##
## DHW_Module.jl
##
## Definition of type "DoHoM"
##
## 11.10.2017
##
## Bruno Hadengue, bruno.hadengue@eawag.ch
##
##===========================
#export foo

module Dohom
import Plots
import PyPlot
export get_timepoints,
    get_numberPeople,
    get_hydrograph,
    produce_eventArray,
    produce_showerHydrograph,
    plot_hydrograph
    

type Hydrograph
    #= Basically gives a series of events at certain time points.
        
        Several methods will be implemented >>
            shower method should output an array with corresponding flows at each time point
            same for tap method, etc.
    =#

    nbPplInHousehold::Int #number of people in household, for now only Integer

    
    timepoints::Array
    probability::Array  #= either stand-alone (same for each time point) or distribution that has the same
                    dimension as "timepoints"=#
    hydrograph::Array

    function Hydrograph(nbPplInHousehold)
        if nbPplInHousehold < 0
            error("Number of people in household cannot be negative!")
        end
        timepoints = collect(1:24)
        probability = ones(size(timepoints)[1], 1)*0.5
        hydrograph = zeros(size(timepoints)[1], 1)
        new(nbPplInHousehold, timepoints, probability, hydrograph)
    end

end

function get_numberPeople(a::Hydrograph)
    return a.nbPplInHousehold
end
    
function get_timepoints(a::Hydrograph)
    return a.timepoints
end

function get_hydrograph(a::Hydrograph)
    return a.hydrograph
end

function produce_eventArray(a::Hydrograph)  #one event per person per day, uniformly distributed
                                            #across the day
    s = size(get_timepoints(a))[1]
    n = get_numberPeople(a)
    eventArray = zeros(s, 1)
    indexArray = collect(1:s)
    
    for j in 1:n                            #create array of randomly picked timepoints
                                            #(non-repeating, because event occurs one at a time)
        pick = rand(indexArray)
        filter!(e->e != pick, indexArray)
        eventArray[pick] = 1.0
    end

    return eventArray
end

function produce_showerHydrograph(a::Hydrograph, eventArray)
    if size(get_hydrograph(a))[1] != size(eventArray)[1]
        return error("Dimensions do not match")
    end

    showerFlow = 0.9::Float64 #[l/m]
    showerTime = 2::Int #[timestep]

    for i in 1:size(eventArray)[1]
        if eventArray[i]==1.0
            for j in 1:showerTime
                if (i+j-1) > size(a.hydrograph)[1]
                    break
                else
                    a.hydrograph[i+j-1] += showerFlow
                end
            end
        else
        end
    end
#    return a
end

function plot_hydrograph(a::Hydrograph)
    PyPlot.pyplot()
    Plots.plot(get_hydrograph(a))
end

end
