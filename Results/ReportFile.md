% Results of the Bayesian Calibration
% GliomaSolver 

# INPUT
The Bayesian calibration was performed for

* the input data provided in the folder 
    * */home/tudorm/GliomaSolver/InputData/*
* Using *2048* samples.

# RESULTS
The results include:

1. **The calibrated model parameters** reported in `Table 1` and `Table 2`.
2. **The posterior probability distribution (PDF)** 
    * With manifold shown in `Figure 1.`
    * And samples stored in `Results/Details/posterior.txt`
3. **The most probable tumor cell density**, given by the maximum a posteriori (MAP) estimate is:
    * Saved in `Results/MAP.nii`
    * With a preview shown in `Figure 2.`


### Calibrated parameters

* The calibrated parameters are reported in:
    * `Table 1`: for the tumor growth model 
    * `Table 2`: for image related parameters
* Reported is MAP, mean and standard deviation (std) of the marginal distribution. 
* The units are 
    * *Dw [cm2/day]; rho [1/day]; T [day];* 
    * *(icx, icy, icz)* is reported in dimension-less units.


*`Table 1:` The calibrated parameters of the tumor growth model:*

|   | *Dw*  | *rho*  | *T* |  *icx* | *icy* | *icz* |
|---|---|---|---|---|---|---|
| MAP  | 0.00491672  |  0.0227968  | 319.55  | 0.249936  | 0.628265  | 0.651254 |
| mean | 0.0044 |  0.0201 | 367.3343 | 0.2499 | 0.6284 | 0.6513 |
| std  | 0.0005  |  0.0024  | 47.5850  | 0.0001  | 0.0006  | 0.0001 |

*`Table 2:` The calibrated parameters of the image model:*

 |   | *sigma*  | *b*  | *ucT1*  |  *ucFLAIR*  | *sigma-alpha* |
|---|---|---|---|---|---|
| MAP  | 0.248653  | 0.742373  | 0.662006  | 0.423341  | 0.0760018  |
| mean | 0.2306 | 0.7400 | 0.6614 | 0.4227 | 0.0763 |
| MAP  | 0.0123  | 0.0093  | 0.0019  | 0.0014  | 0.0006  |


### Posterior probability distribution 

![The results of the Bayesian calibration. **Above the diagonal:** Projection of the TMCMC samples of the posterior distribution in 2D parameter space. The colors indicate likelihood values of the samples. The number in each plot shows the Pearson correlation coefficient between the parameter pairs. **Diagonal:** Marginal distributions obtained with Gaussian kernel estimates. **Below the diagonal:** Projected densities in 2D parameter space constructed by 2D Gaussian kernel estimates.](Details/PosteriorPDF.jpg)

 
### Tumor Cell Density 

![Overview of the input modalities and the inferred MAP tumor cell density. Shown is a middle slice across the MAP tumor cell density.](Details/Overview.jpg)


# References
Please cite

* Lipkova et al.: *Personalized Radiotherapy Planning for Glioma Using Multimodal Bayesian Model Calibration*, preprint arXiv:1807.00499, (2018)
* Rossinelli D, et al.: *Mrag-i2d: Multi-resolution adapted grids for remeshed vortex methods on multicore architectures.* Journal of Computational Physics 288:1–18, (2015).
* P. E. Hadjidoukas et al.: *“Pi4u: A high performance computing framework for bayesian uncertainty quantification of complex models,* Journal of Computational Physics, 2015.
 
#### SEE ALSO
The GliomaSolver source code and all documentation may be downloaded from
<http://COMING-SOON/>.

