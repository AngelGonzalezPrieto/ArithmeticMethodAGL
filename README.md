# Arithmetic Method AGL

This is a `SageMath` script that computes the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomial of the <img src="https://render.githubusercontent.com/render/math?math=\mathrm{AGL}_1(\mathbb{C})">-representation variety over a compact orientable surface of genus <img src="https://render.githubusercontent.com/render/math?math=g">, <img src="https://render.githubusercontent.com/render/math?math=\Sigma_g">. That is, the space of group homomorphisms
<center>
<img src="https://render.githubusercontent.com/render/math?math=\rho: \pi_1(\Sigma_g) \to \mathrm{AGL}_1(\mathbb{C}).">
</center>

The computation is performed by counting the number of points of the representation variety over the finite field of <img src="https://render.githubusercontent.com/render/math?math=q"> elements, <img src="https://render.githubusercontent.com/render/math?math=\mathbb{F}_q">.
The calculation is based on the result of Katz in [2]. Roughly speaking, this result shows that, given a <img src="https://render.githubusercontent.com/render/math?math=\mathbb{Z}">-scheme <img src="https://render.githubusercontent.com/render/math?math=X">, 
if the function <img src="https://render.githubusercontent.com/render/math?math=P(q) = |X(\mathbb{F}_q)|"> is a polynomial in 
<img src="https://render.githubusercontent.com/render/math?math=q">, then 
<img src="https://render.githubusercontent.com/render/math?math=P(uv) = E(X(\mathbb{C}))"> is the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomial of 
<img src="https://render.githubusercontent.com/render/math?math=X(\mathbb{C})">.

From this calculation for surfaces of small genus, the existence of a Topological Quantum Field Theory computing the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomials allows us to compute the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomial for arbitrary genus. For further information about the method, please check [1].


## Installation and use

The only prerequisite to run this script is to have installed a working `SageMath` engine. You can either install your local intepreter following [this instructions](https://doc.sagemath.org/html/en/installation/) or use an online interpreter as [CoCalc](https://cocalc.com/).

To run the standalone version of this script, download the `ArithmeticMethodAGL.sage` source file. Once started the `SageMath` interpreter in the path of the file, type

    %run ArithmeticMethodAGL.sage

to load the functions of the script.

At this point, you can compute the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomial of the representation variety over the compact orientable surfaces with genus less or equal than <img src="https://render.githubusercontent.com/render/math?math=g"> by calling the `compute_polynomials` function.
For instance, for computing the <img src="https://render.githubusercontent.com/render/math?math=E">-polynomials up to genus <img src="https://render.githubusercontent.com/render/math?math=g = 3">, just type

    compute_polynomials(3)

**Remark:** This computation may take lot of time.

The repository also includes a `Jupyter notebook` version of the script. This version is optimized to work with `Cython`. To run it, download the `ArithmeticMethodAGL.ipynb` file. Then, open a Jypyter notebook by typing `jypyter notebook` in a terminal and open the downloaded file. The usage is analogous to the standalone version.

## References

[1] Á. González-Prieto, M. Logares and V. Muñoz, *Representation variety for the rank one affine group*, arXiv:2005.01841.

[2] T. Hausel and F. Rodrı́guez-Villegas, *Mixed Hodge polynomials of character varieties*. With an appendix by
Nicholas M. Katz, Invent. Math., 174 (2008), 555–624.

## Authors
 * Ángel González-Prieto (Universidad Politécnica de Madrid)
 * Marina Logares (Universidad Complutense de Madrid)
 * Vicente Muñoz (Universidad de Málaga)

For reporting bugs, please contact us at <angel.gonzalez.prieto@upm.es>. Comments or suggestions are also very welcome!
