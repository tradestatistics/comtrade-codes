
<!-- README.md is generated from README.Rmd. Please edit that file -->
Description
-----------

Scripts to recreate the trade data available at the [Observatory of Economic Complexity](http://atlas.media.mit.edu/en/).

We have a repo explaining the methodological details. Please visit [OEC Documentation](https://observatory-economic-complexity.github.io/oec-documentation/) and the [Official website](http://atlas.media.mit.edu/en/) for the details.

These scripts are released under MIT license.

How to use this project
-----------------------

While you can run the scripts from UNIX terminal, we highly recommend [RStudio](https://www.rstudio.com/).

Each project is organized as an RStudio project. Each project contains a master script titled `0-some-function.R` at the top level but some projects such as *Product Space* are organized in subfolders where each subfolder contains a master script.

The master script, for any case, runs a function with user prompt and/or simple scripts. The safe way to run this without errors is to open the project and then run the master script from RStudio.

[OEC Packages Snapshot](https://github.com/observatory-economic-complexity/oec-packages-snapshot) contains a bundle to avoid dependencies or packages related problems, but this project already contains an unbundled set of packages to ease reproducibility.

You can read more about RStudio projects [here](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects).

Project structure
-----------------

    oec-comtrade-codes
    └── README.md
    └── README.Rmd
    └── 0-download-codes.R
    └── packrat

Output
------

The script generates different files at the top of the project.

### Generated files

#### Country codes (xls)

    ## Skim summary statistics  
    ##  n obs: 288    
    ##  n variables: 9    
    ## 
    ## Variable type: character
    ## 
    ## variable                   missing   complete   n     min   max   empty   n_unique 
    ## -------------------------  --------  ---------  ----  ----  ----  ------  ---------
    ## Country Abbrevation        0         288        288   3     53    0       288      
    ## Country Fullname English   0         288        288   4     72    0       288      
    ## Country Name English       0         288        288   3     44    0       288      
    ## Cty Comments               3         285        288   4     43    0       9        
    ## End Valid Year             0         288        288   4     4     0       19       
    ## ISO2-digit Alpha           0         288        288   2     4     0       240      
    ## ISO3-digit Alpha           0         288        288   3     4     0       246      
    ## Start Valid Year           0         288        288   4     4     0       15       
    ## 
    ## Variable type: numeric
    ## 
    ## variable       missing   complete   n     mean     sd       p0   p25      median   p75   p100   hist     
    ## -------------  --------  ---------  ----  -------  -------  ---  -------  -------  ----  -----  ---------
    ## Country Code   0         288        288   451.85   258.85   0    230.75   464      667   899    ▇▆▇▆▇▇▆▇

#### Country codes (json)

    ## Skim summary statistics  
    ##  n obs: 255    
    ##  n variables: 2    
    ## 
    ## Variable type: character
    ## 
    ## variable   missing   complete   n     min   max   empty   n_unique 
    ## ---------  --------  ---------  ----  ----  ----  ------  ---------
    ## id         0         255        255   1     3     0       255      
    ## text       0         255        255   3     32    0       255

#### Official correspondence between UN COMTRADE codes

    ## Skim summary statistics  
    ##  n obs: 51841    
    ##  n variables: 11    
    ## 
    ## Variable type: character
    ## 
    ## variable   missing   complete   n       min   max   empty   n_unique 
    ## ---------  --------  ---------  ------  ----  ----  ------  ---------
    ## BEC4       0         51841      51841   1     4     0       20       
    ## HS02       0         51841      51841   4     6     0       5226     
    ## HS07       0         51841      51841   4     6     0       5054     
    ## HS12       0         51841      51841   4     6     0       5207     
    ## HS17       0         51841      51841   4     6     0       5389     
    ## HS92       0         51841      51841   4     6     0       5022     
    ## HS96       0         51841      51841   4     6     0       5115     
    ## SITC1      0         51841      51841   4     5     0       1306     
    ## SITC2      0         51841      51841   4     5     0       1837     
    ## SITC3      0         51841      51841   4     5     0       3122     
    ## SITC4      0         51841      51841   4     5     0       2971

#### Official list of UN COMTRADE codes

    ## Skim summary statistics  
    ##  n obs: 51760    
    ##  n variables: 6    
    ## 
    ## Variable type: character
    ## 
    ## variable         missing   complete   n       min   max    empty   n_unique 
    ## ---------------  --------  ---------  ------  ----  -----  ------  ---------
    ## Classification   0         51760      51760   2     2      0       11       
    ## Code             0         51760      51760   1     6      0       13616    
    ## Code Parent      11        51749      51760   1     5      0       2542     
    ## Description      0         51760      51760   3     1040   0       20546    
    ## isLeaf           0         51760      51760   1     1      0       2        
    ## Level            0         51760      51760   1     1      0       7

Software details
----------------

Here the version information about R, the OS and attached or loaded packages for this project:

    ## R version 3.4.3 (2017-11-30)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 16.04.3 LTS
    ## 
    ## Matrix products: default
    ## BLAS/LAPACK: /opt/intel/compilers_and_libraries_2017.5.239/linux/mkl/lib/intel64_lin/libmkl_gf_lp64.so
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] bindrcpp_0.2 magrittr_1.5
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.15     bindr_0.1        knitr_1.20       tidyselect_0.2.4
    ##  [5] R6_2.2.2         rlang_0.2.0      highr_0.6        stringr_1.3.0   
    ##  [9] skimr_1.0.1      dplyr_0.7.4      tools_3.4.3      packrat_0.4.8-1 
    ## [13] htmltools_0.3.6  yaml_2.1.17      readxl_1.0.0     rprojroot_1.3-2 
    ## [17] digest_0.6.15    assertthat_0.2.0 tibble_1.4.2     tidyr_0.8.0     
    ## [21] purrr_0.2.4      glue_1.2.0       evaluate_0.10.1  rmarkdown_1.9   
    ## [25] stringi_1.1.6    compiler_3.4.3   pander_0.6.1     pillar_1.2.1    
    ## [29] cellranger_1.1.0 backports_1.1.2  jsonlite_1.5     pkgconfig_2.0.1

The MIT License
---------------

Copyright (c) 2017, Datawheel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
