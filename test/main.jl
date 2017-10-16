##===========================
##
## Project WENexH_Trial
##
## main.jl
##
## script testing the Dohom "Domestic Hot Water Model"
##
##
## Bruno Hadengue, bruno.hadengue@eawag.ch
##
##===========================

push!(LOAD_PATH, "/home/hadengbr/Polybox/EAWAG/04_Programming/")
import Dohom_Trial
import Plots
import PyPlot

reload("Dohom")

a = Dohom.Hydrograph(10)

eventArray = Dohom.produce_eventArray(a)

Dohom.produce_showerHydrograph(a, eventArray)

#plot(a.hydrograph)

Dohom.plot_hydrograph(a)

