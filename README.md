# README - Call Modeling Scripts with and without Location

This repository contains MATLAB/Octave functions to estimate and optimize telephone call models (with or without location information) using **Projected Gradient** methods. Below is a brief description of each function and usage instructions.

The article can be found here: https://arxiv.org/abs/2410.11103
---

## 1. Main Functions

### 1.1 `lambda_missing_location.m`
**Signature:**
```matlab
function [lambdas_missing, lambdas_nomissing, probs, prob] = lambda_missing_location(T, G, R, P, nbCalls, nbObservations, nb_missing_calls, durations)
```
**Description:**  
- Calculates call rates (\(\lambda\)) considering scenarios where location is missing (`lambdas_missing`) and where location is available (`lambdas_nomissing`).  
- Also computes the global probability (`prob`) of a call lacking location and a tensor `probs(t,g,p)` for each combination of time, group, and priority.

### 1.2 `oracleGradientMissing.m`
**Signature:**
```matlab
function [gradientl, gradientp] = oracleGradientMissing(nbObservations, nbCalls, nb_missing_calls, neighbors, lambda, prob, G, T, R, P, alpha, durations, Groups, whichgroup, weight)
```
**Description:**  
- Returns gradients `gradientl` (with respect to \(\lambda\)) and `gradientp` (with respect to probabilities `prob`) for the classic "Missing Location" model.  
- Uses neighborhood information (`neighbors`) and clusters (`Groups`, `whichgroup`) to penalize differences between nearby regions/times.

### 1.3 `oracleGradientMissingModel2.m`
**Signature:**
```matlab
function [gradientl] = oracleGradientMissingModel2(nbObservations, nbCalls, nb_missing_calls, neighbors, lambda, G, T, R, P, alpha, durations, S, probs, sample_missing_calls, sample_calls)
```
**Description:**  
- Computes the gradient only with respect to \(\lambda\) for **Model 2**, which uses sample data (`sample_missing_calls`, `sample_calls`) and Monte Carlo (`S`) to estimate the likelihood function.  
- Designed for scenarios where some observations lack location information and `probs` defines the distribution of missing locations.

### 1.4 `oracleObjectiveMissing.m`
**Signature:**
```matlab
function [fL, fp] = oracleObjectiveMissing(nbObservations, nbCalls, nb_missing_calls, neighbors, lambda, prob, T, R, P, G, alpha, durations, Groups, whichgroup, weight)
```
**Description:**  
- Returns the objective function value `fL` and the penalty term `fp` associated with probabilities `prob`, in the classic call model without location.  
- Includes smoothing terms (differences between neighboring regions and clusters defined in `Groups`).

### 1.5 `oracleObjectiveMissingModel2.m`
**Signature:**
```matlab
function [fL] = oracleObjectiveMissingModel2(nbObservations, nbCalls, nb_missing_calls, neighbors, lambda, T, R, P, G, alpha, durations, S, probs, sample_missing_calls, sample_calls)
```
**Description:**  
- Computes the objective function for **Model 2**, focused on samples of missing location (`sample_missing_calls`) and known location (`sample_calls`).  
- Uses Monte Carlo simulations controlled by `S` and the probability matrix `probs`.

### 1.6 `projectedGradientMissingLocation.m`
**Signature:**
```matlab
function [x, fVal] = projectedGradientMissingLocation(nbObservations, nbCalls, nb_missing_calls, neighbors, G, T, R, C, sigma, x, prob, iterMax, alpha, epsilon, durations, Groups, whichgroup, weight)
```
**Description:**  
- Executes the **Projected Gradient Method** to optimize the classic missing location model.  
- Returns the solution `x` (the \(\lambda\) estimates) and `fVal` (history of objective function values across iterations).  

### 1.7 `projectedGradientMissingLocationModel2.m`
**Signature:**
```matlab
function [x, fVal] = projectedGradientMissingLocationModel2(nbObservations, nbCalls, nb_missing_calls, neighbors, G, T, R, C, sigma, x, probs, S, iterMax, alpha, epsilon, durations, sample_missing_calls, sample_calls)
```
**Description:**  
- Similar to `projectedGradientMissingLocation`, but adapted to **Model 2**, which uses Monte Carlo samples.  
- Optimizes only with respect to \(\lambda\), considering `sample_missing_calls` and `sample_calls`.

---

## 2. How to Run

1. **Organize the Files**  
   - Place each function in a `.m` file corresponding to its function name.

2. **Load Data**  
   - Define `nbObservations`, `nbCalls`, `nb_missing_calls`, `neighbors`, `durations`, `T, G, R, P`, `Groups`, etc.

3. **Call the Functions**  
   ```matlab
   [x, fVal] = projectedGradientMissingLocation(...);
   ```

4. **View Results**  
   - `x`: \(\lambda\) estimates  
   - `fVal`: objective function history

---

For questions or issues, open an Issue in the repository.

