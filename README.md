<p align="center">
  <img src="images/Library_Logo.png" alt="Library logo" width="200"/>
</p>

# Modelica LargeTESmtk Library

Welcome to the development site of the Modelica *LargeTESmtk* (LargeTESModelingToolkit) library.

## About

The *LargeTESmtk* is a Modelica-based toolkit for the modeling and simulation of large-scale pit (PTES) and tank (TTES) thermal energy storage systems. In addition to an easy-to-use Modelica library with pre-built storage models, the toolkit's features should provide the foundation for developing new storage models customized to the wanted application.   
<p align="center">
  <figure>
    <img src="images/LargeTESmtk_Overview.png" alt="LargeTESmtk Overview" style="width: 100%;"/>
  </figure>
</p>

<p align="center">
  <strong>Figure 1:</strong> Overview of (planned) <i>LargeTESmtk</i> features.
</p>

## Application

Possible applications of the library models are in simulations studies...
- ...to address relevant storage design questions (e.g., regarding volume, geometry, or insulation)
- ...to investigate long-term effects (e.g., the development of the storage performance and ground temperatures over the operation period)
- ...to evaluate the storage interaction in different system integration concepts (e.g., with solar thermal plants, heat pumps, or combined heat and power plants)
- ...

## Model Verification and Validation

The two main PTES and TTES models have been thoroughly tested in several model verification and validation studies (see [Related Publications](#related-publications)).

## Development Status

Current status:

- The library is available in a first basic version, including the TTES model(s) and the corresponding main submodels, which can be used as building blocks for new storage models.

Upcoming: 

- The PTES model(s) exist in an initial version and have already been subjected to model verification and validation studies 
(see [Related Publications](#related-publications)). We are currently in the process of preparing
these models for publication (e.g., refining their structure and improving their usability).
- Enhance model documentation
- Add further example models demonstrating the application of the library

## Tool Support

The library was developed and tested in *Dymola* (up to version 2025x Refresh 1). Testing in *OpenModelica* is planned for the future.

If you have used/tested the library with any other Modelica-based simulation tool, please let us know.

## License

The Modelica *LargeTESmtk* library is available under the Mozilla Public License (MPL 2.0).
See [LICENSE](https://github.com/LargeTESmtk/LargeTESmtk/blob/main/LICENSE) file.

## Dependencies

This library uses models from the Modelica [IBPSA](https://github.com/ibpsa/modelica-ibpsa) library, version 4.0.0 (development status).

**Note:**  
Commit [`e6de2f3`](https://github.com/ibpsa/modelica-ibpsa/commit/e6de2f3eb075d20452092441f78ee36adfaf5824) (date: 2025-02-16) is the latest version tested with this project. Other versions may not be fully compatible.

You can obtain the correct library version in two ways:

- **Manual download:** [Download the source at this commit](https://github.com/ibpsa/modelica-ibpsa/tree/e6de2f3eb075d20452092441f78ee36adfaf5824).
- **Recommended (submodule):** After cloning this repository, run:
  ```bash
  git submodule update --init --recursive
  ```
  This will download the library into `ExternalLibraries/IBPSA`.

The Modelica *IBPSA* library is licensed under a 3-clause BSD-license. See [Modelica IBPSA library license](https://htmlpreview.github.io/?https://github.com/ibpsa/modelica-ibpsa/blob/master/IBPSA/legal.html).

## How to contribute

Any contribution to the development of the *LargeTESmtk* is greatly appreciated.

You can report any issues using the [Issues](https://github.com/LargeTESmtk/LargeTESmtk/issues) section 
or contribute in form of [Pull requests](https://github.com/LargeTESmtk/LargeTESmtk/pulls).

If you appreciate our work, please star ⭐ this repository by clicking the button in the top-right corner of this page. Thank you!

## How to cite

Reisenbichler-S., Michael, Franz Wotawa, Keith O’Donovan, Carles Ribas Tugores, and Franz Hengel. 
“LargeTESModelingToolkit: A Modelica Library for Large-Scale Thermal Energy Storage Modeling and Simulation.” 
In *Proceedings of the 15th International Modelica Conference*, 337–346. Aachen, 2023. https://doi.org/10.3384/ecp204337.

```
@inproceedings{reisenbichler-s_largetesmodelingtoolkit_2023,
	author = {Reisenbichler-S., Michael and Wotawa, Franz and O’Donovan, Keith and Tugores, Carles Ribas and Hengel, Franz},
	title = {{LargeTESModelingToolkit}: {A} {Modelica} {Library} for {Large}-scale {Thermal} {Energy} {Storage} {Modeling} and {Simulation}},
	booktitle = {Proceedings of the 15th {International} {Modelica} {Conference}},
	pages = {337--346},
	address = {Aachen},	
	year = {2023},
	doi = {10.3384/ecp204337},
	url = {https://ecp.ep.liu.se/index.php/modelica/article/view/942},
	urldate = {2024-03-17},
}
```

## Contact

For questions or feedback, please contact [mic.reisenbichler@gmail.com](mailto:mic.reisenbichler@gmail.com).

## Related Publications

- Reisenbichler-S., Michael, Franz Wotawa, Keith O’Donovan, Carles Ribas Tugores, and Franz Hengel. “LargeTESModelingToolkit: A Modelica Library for Large-Scale Thermal Energy Storage Modeling and Simulation.” In *Proceedings of the 15th International Modelica Conference*, 337–346. Aachen, 2023. https://doi.org/10.3384/ecp204337.
- Reisenbichler-S., Michael, Ioannis Sifnaios, and Franz Wotawa. “Validation of a Pit Thermal Energy Storage Model: Demonstration of a Comprehensive Approach.” *Journal of Energy Storage* 116 (April 30, 2025): 115680. https://doi.org/10.1016/j.est.2025.115680.
- Reisenbichler, Michael, Keith O’Donovan, Carles Ribas Tugores, Wim van Helden, and Franz Wotawa. “Towards More Efficient Modeling and Simulation of Large-Scale Thermal Energy Storages in Future Local and District Energy Systems.” In *Proceedings of the 17th IBPSA Conference*, 2155–2162. Bruges, 2021. https://doi.org/10.26868/25222708.2021.30911.
- Ochs, Fabian, Abdulrahman Dahash, Alice Tosatto, Michael Reisenbichler, Keith O’Donovan, Geoffroy Gauthier, Christian Kok Skov, and Thomas Schmidt. “Comprehensive Comparison of Different Models for Large-Scale Thermal Energy Storage.” In *Proceedings of the International Renewable Energy Storage Conference 2021 (IRES 2021)*, 36–51. Atlantis Press, 2022. https://doi.org/10.2991/ahe.k.220301.005.
- Schmidt, Thomas, and Abdulrahman Dahash. “Modelling Guidelines - Round Robin Test Case Description (for Comparative Simulations).” Task 39 - Large Thermal Energy Storages for District Heating: Subtask C - Round Robin Simulation. IEA ES TCP, June 19, 2024. https://iea-es.org/task-39/deliverables/.

## Acknowledgments

This library was originally developed by Michael Reisenbichler-Sommerhofer as part of his doctoral dissertation. The development was supported by [AEE INTEC](https://www.aee-intec.at/en/) as part of his employment as a research associate at the institute. 

Partial funding was provided by the following research projects: *DevMoTES* (Austrian Research Promotion Agency (FFG), project no. 878848), *giga_TES* (FFG, project no. 860949), *MoreStore* (Austrian Cooperative Research (ACR), project no. SP-2020-09), and *IEA ECES Annex/Task 39* (FFG, project no. 883015).

Special thanks to *Keith O'Donovan* and *Carles Ribas Tugores* for their support during the early stages of development.

We gratefully acknowledge the developers and contributors of the Modelica *IBPSA* library for their valuable work and for making their models available to the community.
