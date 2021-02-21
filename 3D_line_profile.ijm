// this macro extracts the line profile information (plot profile images + plot values) of each slice of a 3D stack
// !!! Important: this macro requires the one-time installation of the plugin called "Read and Write Excel" (https://github.com/bkromhout/Read_and_Write_Excel_Modified) 
// To do this: Help -> Update.. -> Manage update sites -> check "ResultsToExcel" checkbox; close window; press "Apply changes"; restart ImageJ
// Prerequisites: all 3D stacks should be placed in one folder; assumes 'tiff' extension; 
// 1. the user chooses the folder where the images are 
// 2. once an image is opened and when prompted, the user draws a line on the area of interest and clicks OK 
// 3. a new folder called "Line profiles" is created within the images folder 
// 4. Two sets of results for each image: 
//           - a 3D stack of line profile plots for each slice
//           - an Excel file; each sheet in the file has the line profile values: intensity (Y) and distance (X, in micrometers) for each slice in the z-stack  
//           - an Excel file outputting the pixel size used for each image 


macro "Stack profile Plot" {
	imageDir = getDirectory("Choose the directory of your images");
	ResultsDir = imageDir + "Line profiles" + File.separator;              //create folder, inside the directoy with the images, where results will be 
	File.makeDirectory(ResultsDir);
	processFolder(imageDir);
	function processFolder(imageDir) {
		list = getFileList(imageDir); 
		for (i = 0; i < list.length; i++) {			
			processFile(imageDir, list[i]);
		} 
	}
	function processFile(imageDir, file) {                                //loop through each file (3d capture)
		ImagePath = imageDir + list[i];
		open(ImagePath);
 
		fileName = file;
		fileNameNoExt = replace(fileName, ".tif", "");
		waitForUser("Draw a line profile on the desired area"); 
		selectImage(file);
		setBatchMode(true);
	    stack1 = getImageID;
	    stack2 = 0;
	    n = nSlices; 
	    getPixelSize(unit, pixelWidth, pixelHeight);	    
	    saveSettings();
	    run("Profile Plot Options...", 
	      "width=1000 height=200");
	    for (i=1; i<=n; i++) {                                            //loop through each slice of z-stack 
	        showProgress(i, n);
	        selectImage(stack1);
	        setSlice(i);
	        run("Clear Results");
	        Y = getProfile();                                            //runs Analyze -> Plot Profile (returns intensity values as an array = profile)    profile = Y
	        //Array.print(Y);
	        len = Y.length;   
	        X = newArray(len); 
	        for (j=0;j<len;j++){
	        	X[j] = j*pixelHeight;                                    //convert X-axis to real pixel values (in um)         realXValues = X (um)
	        }
	        //Array.print(X);  
			for (k=0; k<len; k++){
				setResult("X(um)", k, X[k]);
			}
			for (l=0; l<len; l++){
				setResult("Y", l, Y[l]);
			}			
			LineProfileResultsDir = ResultsDir + "/" + fileNameNoExt + "_LineProfileResults_.xlsx";
			run("Read and Write Excel", "no_count_column file=["+LineProfileResultsDir+"] sheet=Plot_Values_Slice_" + i);    //records all results in an Excel spread sheet  
			run("Clear Results");
			
			selectImage(stack1);
	        run("Plot Profile");                                      //makes dynamic tiff. image of the plot 
	        run("Copy");
	        w = getWidth; h = getHeight; 
	        close();
	        if (stack2==0) {                              
	            newImage("Plots", "8-bit", w, h, 1);     
	            stack2 = getImageID;
	        } else {
	            selectImage(stack2);     
	            run("Add Slice");
	        }
	        run("Paste");       
	    } 
	    setSlice(1);
	    selectWindow("Plots");           
	    saveAs(ResultsDir + "/" + fileNameNoExt + "_Plot.tiff");  //save dynamic plot image                     
	    close(); 
	    selectImage(file);  
	    close(); 
	    restoreSettings();
	    run("Clear Results");
	    setBatchMode(false);	    
	    print("file name:", fileNameNoExt);
	    print("pixel dimensions:", pixelWidth, "x", pixelHeight, unit);
	    selectWindow("Log"); 
	    saveAs("Text", ResultsDir + "/" + fileNameNoExt + "_Info.txt");
	    selectWindow("Log"); 
	    print("\\Clear");
	    close("Log");
	    run("Clear Results");
	    close("Results");
	}
}


