# openscad
just playing around with OpenSCAD

## White House Model

The `white_house.scad` file contains an OpenSCAD script that creates a 3D approximation of the White House, including:

- Main central building with neoclassical architecture
- North Portico with 6 columns and triangular pediment
- South Portico with semi-circular design and 8 columns
- East and West Wings
- Hip roofs on all structures

### Usage

To view and render the model:

```bash
# Open in OpenSCAD GUI
openscad white_house.scad

# Export to STL for 3D printing
openscad -o white_house.stl white_house.scad

# Export to PNG image
openscad -o white_house.png --imgsize=1200,900 --camera=0,0,0,60,0,45,150 white_house.scad
```

### Customization

You can modify the parameters at the top of the file to adjust the dimensions:
- `main_building_width`, `main_building_depth`, `main_building_height` - Main building dimensions
- `wing_width`, `wing_depth`, `wing_height` - Wing dimensions
- `column_radius`, `column_height` - Column specifications
- Color definitions for buildings, roofs, and columns
