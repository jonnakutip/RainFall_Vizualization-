
# RFainFallViz.m: Visualization of Statewise Rainfall

This MATLAB script visualizes rainfall data over India, overlaying state boundaries to provide geographical context. It reads rainfall data from a netCDF file and state boundary information from a shapefile, then generates an animated GIF showing the rainfall distribution over time.

## Key Functionality

1.  **Data Loading:**
    * Reads rainfall data (longitude, latitude, time, rainfall values) from a netCDF file (`RainFall.nc`).
    * Loads coastline data from `coastlines.mat`.
    * Loads state boundary data from a shapefile (`india27-11.shp`).

2.  **Time Handling:**
    * Converts time data from the netCDF file into MATLAB datetime objects, creating a sequence of daily dates.

3.  **Visualization Loop:**
    * Iterates through a subset of the time steps (limited to 100 for efficient GIF creation).
    * For each time step:
        * Plots the coastline.
        * Generates a `pcolor` plot of the rainfall data, using `shading interp` for smooth color transitions.
        * Overlays state boundaries from the shapefile as white lines.
        * Adds a colorbar and sets the colormap to `jet`.
        * Adds a title indicating the date of the rainfall data.
        * Captures the current figure as an image frame.

4.  **GIF Animation Creation:**
    * Combines the captured image frames into an animated GIF file (`RainFall_1981-2014.gif`).
    * Sets the GIF to loop infinitely and adjusts the frame delay.
    * Uses `imwrite` to write the image data to the gif file.

## Purpose

The script aims to provide a visual representation of rainfall patterns across Indian states over time. This visualization can be useful for:

* Analyzing rainfall distribution.
* Identifying regional rainfall variations.
* Understanding temporal changes in rainfall.

## Dependencies

* MATLAB
* NetCDF Toolbox (for reading netCDF files)
* Mapping Toolbox (for reading shapefiles and plotting coastlines)
* `coastlines.mat` file containing coastline data.
* `RainFall.nc` netCDF file containing rainfall data.
* `india27-11.shp` shapefile containing the state boundaries.

## Usage Notes

* Ensure that the netCDF file and shapefile are in the same directory as the MATLAB script or provide the correct file paths.
* The script limits the animation to the first 100 time steps for efficiency in GIF creation. If you want to create a longer animation, modify the loop limits.
* The output GIF file will be saved in the current working directory.
