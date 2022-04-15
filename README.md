### Andrey Yamkovoy, Arshad Mohammed, Joe Hand, ZemynaKaite

# CSU 11013 Group 9

# Programming Project Report

## Introduction


Our project presents Covid-19 data in an easy-to-understandand transparent manner, with a strong
emphasis on user engagement, ensuring that whoeveris viewing the software has full control over
what data they want to see and how it is presented.

We started by determining what tasks needed to becompleted and how we should divide them
among ourselves. After that, we started focusing onour individual assignments. Each section below
explains what each of us contributed to the project.

**Note: Before loading the program for the first time,complete the “SQLite Installation
Instructions” near the bottom of the report.**

## Andrey

In the project I worked on the acquisition and formattingof the data to make it more accessible for
my group members. I also worked on making severalvisualizations of the data in forms of tables in
order to be able to see the data in a readable formatin the application.

Using the SQuelized processing library and an SQLdatabase, we were able to send custom queries
that would return any data we wanted in the processingTable format which we could then
manipulate and create visualisations from. I thenwrote the class DB_import which imports all the
data into the database in an effective manner usingstringBuilders and indexes.

I made the TextWidget class to be able to have userinput through text boxes. I then began work on
implementing on table visualization of the data whichis variable with the amount of data it receives
such that it changes row/column size and automaticallychanges column width depending on the
longest value in a set of rows.


These tables are made by using the Grid and Cell classes that I believe are also impressive due to the
fact that I implemented them in such a way that elementsof the table are selectable by up/down
keys and the tables scroll up and down when the currentselected element goes offscreen.

The Cumulative Cases Screen shows 2 tables which showthe total cases for all counties/states,
amount of cases, the population and the cases permillion in a specific county and area for a specific
date. The Timeline cases Screen shows 3 tables whichallow you to select a specific county and or
area and look at the cases and cases per million amountsover a range of dates.

The tables are fully interactive and display whichis currently selected and when a county or area is
selected the tables update when you hit the updatebutton.

## Arshad

I worked on setting up communications between theteam and setting up a decent workflow
between the using discord. The discord proved tobe incredibly helpful, especially when debugging
and committing.

I wanted to do a graphical representation of the coviddata, and decided on a tree map visualisation.
I found a helpful library called Squarify, howeverit wasn't effective enough to use because it was
difficult to store information within the classesprovided in the library. I wrote up the library in
processing to work with, but it utilised recursiveconstructors, which were difficult to use and didnot
work in processing, so I scrapped that and importedthe library normally.

I started by making the tree map function with staticvalues. Then I made it so that when I clicked on
the screen it changed the values at random, and afterthat I made it move the x and y coordinates to
the final location. At first, this was a challengingtask, and I spent a week trying to find out how todo
it. Once this was done, I implemented the same systemfor the x and y coordinates but for the length
and width of each rectangle in the tree map. I nowhad an animated tree map.

Next I had to use the data set parsed by Andrey andmap that on. To do this I used another class and
object system to run parallel object arrays with theobject arrays for the treeMap class.
I then used a heat map for the tree map and addedbutton widgets for moving different dates.
I made two versions; One was fifty states, and theother was the top ten states. We ultimately
decided on the tree map with the top ten states.



## Joe

I worked on graphical representation of the data,specifically creating bar charts to show the amount
of cases specific to areas in different states atdifferent dates. I also worked on line charts, whichcan
be used to show the total number of cases in differentstates over time. Both charts use queries to
acquire the data that can be changed by the user usingbuttons on the screen, allowing the user to
change the states and dates of the data they are viewing.

Classes were made for the bars, points as well asthe lines to connect the points. For the Bar classan
ArrayList of Bar objects is made when creating thebar chart on screen. When created, the y-position
of each bar is decreased, with the height of eachincreased at the same time, allowing for an
animated movement of the bar. A similar method isused for the points, though only a y-position
variable for the points is used. The line class simplydraws a line between two points, taking in those
points and a colour as parameters.

When a user presses a button to change the query,the ArrayLists are emptied and then remade
with the new values. When the mouse is hovering overa point/bar, more specific information is
given regarding the data.

My main issue as I worked on the charts was makingsure that the bars/points animated correctly
and presented themselves on the graph correctly. Themap() method is used to make sure that the
size of the bars/points is kept within the graph.The speed at which points/bars move along the
screen slowly decreases, giving a smoother effectwhile also limiting how far the objects can move
along the screen. I made sure that the speed variabledid not go below 0, to prevent the charts’
animation from going in the wrong direction.

## Zemyna

I began by making a simple default backdrop for allof our screens in PhotoShop, and by creating a
home screen with a title and buttons that broughtyou to all of our different screens. This was
accomplished by using the "Screen" and "Button" classes.I established a simple colour theme for
our project and wrote the case statements that displayedeach different screen.

I decided to work on a map image that would displaythe total cases per each state (up to
28/04/2020) with a simple colour key. First, I foundan image of the United States and uploaded that
to our project, drawing it on the designated "Map"screen. I then made a "State" class, which allowed
me to make each state it's own object. Each statehad its own cropped out image, as well as a


rectangle region within the state (or on the label) with a width and height, a title, a population and
the total cases in that state.

The state would be drawn directly over the originalmap image if the mouse was hovered over the
rectangle region allocated to each state, and thetint of the state was determined by the total cases
in that state, and corresponded to a key drawn onthe left side of the map.

I also introduced a small feature whereby if the userclicked on any of the states, a pop-up on the
right would appear with some key information suchas the name of the state, its population, the
number of cases in that state, the total number ofcases in the United States, and finally the
percentage of cases in that state compared to thetotal number of cases in the United States. The
population and the total cases per state as well asthe percentage were gotten using methods
and/or queries from our Covid database.

Then, I moved on and worked on the "Headline Figures"Screen. This screen displays three simple
Covid figures: the total number of confirmed casesin the United States, the total number of
confirmed cases in the state of California, and thetotal number of confirmed cases in Washington,
DC, the nation's capital, as well as a date showingthe last date on our data set.

After that, I worked on all of the other screens,adding headers and backgrounds to each one to
keep our project's theme consistent. To make it lookas clean and uniform as possible, each screen
has identical borders, headers, and unique sectionsto separate each "part" of a screen.

## Conclusion

When completed, this project included a variety ofvisualisations and displays of the Covid-
dataset we were given. The use of data tables, charts,and graphs, as well as more broad data
representations like the US map and tree map, broughtthe project together and resulted in a
fantastic data viewer.


## Sample output of Line Chart:
![image](https://user-images.githubusercontent.com/75397123/163613730-d53a6f73-c30c-4e66-bcec-26bff8e6658d.png)

## Sample output of the Bar Chart:
![image](https://user-images.githubusercontent.com/75397123/163615277-693e7ea4-85de-4259-b1e6-08dde6a1f8b5.png)


## The Tree Map Data class:
### Tree Map Visualisations, 50 States vs Top 10 States.
![image](https://user-images.githubusercontent.com/75397123/163615738-04d57ff3-741a-4a2e-bbfc-c886e102d860.png)

## Sample output of the US map:
![image](https://user-images.githubusercontent.com/75397123/163616143-076faebd-c5d1-4867-8416-72a3acb36fca.png)


## SQLite Installation Instructions

As we are using an SQL database in order to run theprogram first one must download sqlite and set
the connection path in the setup in the Main tabin order to connect sqlite and the program.

The download for sqlite is in the repository,
![image](https://user-images.githubusercontent.com/75397123/163616705-e9c41c3e-0989-4e5e-b6c3-aaaa081cee73.png)

In order to install it you have to unzip it and placeit into a folder called sqlite or alternatively change
the folder name in the setup of the main.

For example, this is how I did it,
![image](https://user-images.githubusercontent.com/75397123/163616931-d2fb7f3d-8f4b-4cf4-bc36-e8e93b1a8d53.png)

and thus the location of the sqlite file in the connectionpath is

For the connection path in the setup() of the main,you then need to put the path of where you put
the files from the repository so that it finds thedatabase.

For example
![image](https://user-images.githubusercontent.com/75397123/163617208-5ba4d8fd-62ab-4a00-aed9-caddb84ad105.png)


So in the end this is the format that it is in

myConnection = newSQLiteConnection(“jdbc:sqlite:/Replacewith Letter of disk space where program
is placed:\\Replace with path of where you put thefolder containing the program”);
Full example: myConnection = new
SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\Desktop\\Programming
projectrepoistory\\CS1013-2021-9.\\covid_data.db");


