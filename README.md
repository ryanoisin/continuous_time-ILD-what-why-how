# continuous_time-ILD-what-why-how
R code repository for [Ryan, Kuiper and Hamaker (2018). A continuous time approach to intensive longitudinal data:
What, Why and How?](https://ryanoisin.github.io/files/RyanKuiperHamaker_preprint.pdf) In K. v. Montfort, J. H. L. Oud & M. C. Voelkle (Eds.) *Continuous time modeling in the Behavioral and Related Sciences* New York: Springer.

The code in this repository recreates the empirical example, and accompanying figures, which appear in the above chapter.

The empirical example is based on a publically available, single-subject time-series dataset from "Critical Slowing Down as Personalized Early Warning Signal for Depression", Wichers & De Groot (2016).

The dataset is available [here](https://osf.io/c6xt4/download) with a full description of the dataset available from [Kossakowski et al (2017)](http://doi.org/10.5334/jopd.29)

## Prerequisites

To estimate the model, users must first [download](https://osf.io/c6xt4/download) and unzip the empirical data. Otherwise, all figures can be generated using the *results.RData* file supplied in the **Analysis** folder.

## Contents

**Analysis**: Obtaining parameter estimates from the empirical example
  - *appendixb.R* - estimate a bivariate CT-VAR(1) model using the [ctsem](https://cran.r-project.org/web/packages/ctsem/index.html) package
  - *results.RData* - a data-file containing the model estimates from running appendixb.R
  
 **Figure generation**: Visualising the estimated model
  - *IRF and lagged effects generation.R* - generates Impulse Response Functions (Figure 1) and lagged-parameter plots (Figure 3)
  - *Vector Field generation.R* - generates vector field plots (Figures 2 and 4)
  


