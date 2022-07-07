# OpenSCAD library
Here my openSCAD files are stored and made available to the public under the MIT license.

- In the **lib** folder you find the libraries I use for my 3D models.
- The **models** folder stores my 3D models created for my FDM printer.

## lib
The library files can imported in your script with `use <lib/filename.scad>`

#### bezier.scad
`quadratic_bezier(a,b,c,n)`
- a and b are the start and end of the curve. 
- c determines the curve.
- n is the number of fragments

`cubic_bezier(a,b,c,d,n)`
- a and b are the start and end of the curve. 
- c and d determine the curve.
- n is the number of fragments

## models

#### speakerParts
Multiple parts to create my open baffle(dipole) speakers.


