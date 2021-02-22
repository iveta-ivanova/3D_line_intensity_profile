# 3D_line_intensity_profile

The macro extracts the line profile intensity information (plot profile images + plot values) of each slice of a 3D stack. 
It is useful in the very specific case if you hava a large number of 3D TIFF files, where  you need to quantify the intensity along the stack. The only user input required is the image directory and to manually draw a line for each image.
A 3D beads image was used for testing and for the instructions in this short manual.  
Due to the likely vastly varying s:n (including within a single stack), Gaussian fit and hence FWHM extraction could not be automated. Instead, the data is exported in Excel files for further plotting if needed. 

### Before you start: 
1)	This macro is calling a non-built-in plug-in; hence requires the one-time installation of a plugin called "Read and Write Excel" (https://github.com/bkromhout/Read_and_Write_Excel_Modified) 

To do this: Help -> Update.. -> wait for update to finish … ->  Manage update sites -> check "ResultsToExcel" checkbox; close window; press "Apply changes"; restart ImageJ

![alt text](https://github.com/iveta-ivanova/3D_line_intensity_profile/blob/master/screenshots/Capture.PNG "Installing Read and Write Excel")

2)	All 3D stacks should be in .tiff format and placed in one folder. **Images which are not 3D stacks and non-tiff images will crash the macro.** 

### Using the macro: 

1.	As soon as the macro is initiated, the user is prompted to choose folder where the images are located. 

2.	The macro will iterate through the images in the folder. Once an image is opened, the user is prompted to draw a line profile for the given 3D stack. 
Feel free to scroll throw the z-stack to find the optimum position for the line profile, it will not affect the performance. 

![alt text](https://github.com/iveta-ivanova/3D_line_intensity_profile/blob/master/screenshots/3.PNG "Line profile on bead sample")

3.	A new folder called "Line profiles" is created within the images folder – this folder will hold all the results. Three files for each 3D stack are returned: 

4.	The macro will now iterate through the slices of the image, producing the following results: 
* A dynamic image of line profile plots (for each slice) – good for visual inspection of the plot profile as a function of z-slice
![alt text](https://github.com/iveta-ivanova/3D_line_intensity_profile/blob/master/screenshots/6.PNG "Line profile on bead sample")

* An Excel file of line profile values: intensity (Y) and distance (X, in micrometers); data for each slice in the z-stack is in a separate tab 
![alt text](https://github.com/iveta-ivanova/3D_line_intensity_profile/blob/master/screenshots/5.PNG "Line profile on bead sample")

* A simple text file with the pixel size used for each image – check this, to ensure the correct pixel size was used in the data output;
![alt text](https://github.com/iveta-ivanova/3D_line_intensity_profile/blob/master/screenshots/7.PNG "Line profile on bead sample")

*Note*: PS: If you run the macro several times, for the same capture, without erasing the contents of the Line profiles folder, the Excel file will not be overwritten. Instead, the Results to Excel macro will keep adding the new set of values to the same Excel file, like so: 

5.	Once the macro successfully saves the results for the given stack, it will automatically prompt the user to draw the line profile for the next image.
