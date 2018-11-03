# Liquidity DSGE model
This repo contains the Dynare files to simulate a NEw Keynesian DSGE model augmented with liquidity conditions. This model is part of a research project on inflation persistence and monetary policy rules. The main repo for this project is available [at this link](https://www.github.com/ceschi/TRPi) (to be published soon).

### How to use these files?


1. `nkdtc.mod` contains the model equations and embeds several specifications. It requires `Dynare` and needs two flags.

	+ calibras = 0 or 1: this flag declare the calibration on the monetary policy rule to be adopted, 0 for the active Central Bank, 0 for the passive one. This flag in turns calls two ancillary files, `usual_tp.mod` and `passive_tp.mod`, respectively. Every option of this flag produces and stores simulated time series for inflation and IRFs for selected and full set of variables, with labelling differences.

	+ `z_flag` = 1 activates an end-of-the-world liquidity shock, and needs to be declared with the previous flag. All other values for `z_flag` turn off this shock.

2. `z_graph.m` runs independently and uses `nkdtc.mod` as an input. It outputs graphs representing the overall behaviour of the stylised economy under two monetary policy regimes, following the end-of-the-world liquidity shock. 

##### Todo list

* extract and plot policy function for each model $\Rightarrow$ Pfeiffer wrote an ad hoc function.





<!-- # DTC
A version in progress of liquidity model in discrete time complementary to empirical analysis carried out [in another repository](https://www.github.com/ceschi/UnemplTaylor/).

#### To do list:
1. Restructure mod file to nest multiple options for full model
    1. Recover i-rate via matlab f
2. Multiple calibrations
    1. Flags for different calibrations and
    2. source out calib to files
3. rewrite eq's for forward-looking current price (look up Fernandez-Villaverde)
4. CES liquidity
5. Liquidity policy funct
 -->