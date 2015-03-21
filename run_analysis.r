run_analysis <- function(path = getwd()){
	## where should the script be, relative to the project data?   the function should take the path to the data as an argument.
	## the function needs to be called run_analysis.R
	## at minimum, the project requires 4 things: the tidy data, the script, a codebook and a readme connecting all the parts.   The codebook and the readme need to be produced using markdown.
		
	## create test data table
	test <- createTable(paste(path, "/test",sep=""), "x_test.txt", "y_test.txt", "subject_test.txt")

	## create training data table
	train <- createTable(paste(path, "/train",sep=""), "x_train.txt", "y_train.txt", "subject_train.txt")
	
	## join the test and training data tables
	complete.data <- rbind(test,train)
	
	## write the joined table to a file called "tidy4.txt" (tidy data from step 4 of the project)
	if(file.exists("tidy4.txt"))
		file.remove("tidy4.txt")
	file.create("tidy4.txt")
	write.table(complete.data, "tidy4.txt", row.name = FALSE)
	
	## create averages per activity
	tidy5.data <- NULL
	for(name in names(complete.data[,4:82]))
		tidy5.data <- data.frame(cbind(tidy5.data,tapply(complete.data[,name],complete.data$Activity_ID,mean)))
	
	## set row and column names
	names(tidy5.data) <- names(complete.data[,4:82])
	tidy5.data <- cbind(read.table("activity_labels.txt")[,2],tidy5.data)
	names(tidy5.data)[1] <- "Activity_Description"
	
	## write the joined table to a file called "tidy5.txt" (tidy data from step 5 of the project)		
	if(file.exists("tidy5.txt"))
		file.remove("tidy5.txt")
	file.create("tidy5.txt")
	write.table(tidy5.data, "tidy5.txt", row.name = FALSE)
}

createTable <- function(relative.path, x.datafile, y.datafile, subject.datafile){
	
	## save working directory
	old.dir <- getwd()
	setwd(relative.path)
	
	## read data into memory
	x.data <- read.table(x.datafile)
	y.data <- read.table(y.datafile)
	subject.data <- read.table(subject.datafile)
	
	names(y.data) <- "Activity_ID"
	names(subject.data) <- "Subject_ID"
	
	## go to parent directory
	setwd("..")
	
	## add column names (read from features file)
	names(x.data) <- as.character(read.table("features.txt")[,2])
	
	## read activity labels
	activity.labels <- read.table("activity_labels.txt")
	
	## restore working directory
	setwd(old.dir)
	
	## extract mean and std columns
	extract.mean <- x.data[,grep("mean",names(x.data))]
	extract.std <- x.data[,grep("std",names(x.data))]
	
	## join the mean and std extractions
	extract.join <- cbind(extract.mean, extract.std)
	
	## associate activity code with names
	for (i in activity.labels[,2]){
		y.data$Activity_Description[y.data[,1] == activity.labels[activity.labels[,2]==i,1]] <- i
	}
	
	## add subject and activity columns
	cbind(subject.data,y.data,extract.join)
}