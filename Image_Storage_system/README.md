# SSIS Image Management Project

This project automates the organization of images by creating a structured file system, 
collecting image names, and storing them in a SQL Server database. 

##Project Overview:

This SSIS project automates the organization and management of images by creating a 
structured file system. It generates directories containing images organized by 
specific names, then collects these names and stores them in a configured SQL Server 
database with multiple tables in their right location. To simplify image retrieval, the project also includes 
an SSRS report, allowing for efficient extraction of images without the need for 
manual searches. The solution streamlines the process of managing large sets of images 
and enhances accessibility through organized storage and reporting.

## Features:
- Organizes images into a file structure by name.
- Stores image data in a SQL Server database.

## How to Run:
1. Clone this repository.
2. Open the SSIS project in Visual Studio.
3. Run the SSIS package to populate the database with image names.

##Sample Data
The file also includes a sample data "Batch" for the project.