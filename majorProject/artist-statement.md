#Artist Statement

##Inspiration
In this work, I am trying to tell users a simple even kind of old story that may happen around us —your friend is missing and you go to find her but meet something uncanny. I got inspirations from a kind of popular real life room escape game I played before. Players must check every item carefully to find clues and extract the inherent logic among the clues you had in order to get the final key to get out of the room. In my artwork, the user also needs to follow the instruction and find settled items and check each of them for several times. Only when some specific result is presented or items clicked by enough times, the next level can be triggered. Step by step, the user will reach the end and get the final fright.

##Method
In the exploration of the theme of “ghost stories”, I pay more attention to the construction of the thrilling atmosphere. So chain lightning, flashlight used by the user and heavy rain are the most important environmental components in this work.

I use noise () to return the Perlin noise value at specified coordinate based on frameCount. And this noise value is between 0 and 1 fluctuating around 0.5. If this value is over 0.7, the brightness of the image house is increased significantly in an instant. After that, the improved brightness value will regress to a relatively low level in the following frames and keep at this level for a while. Repeating the process, the effect of thundering and lightning is presented.

In PImage room, I use loadPixels () this method to load the pixel data for the image into its pixels [] array. And judge the distance between each pixel and cursor: if the distance is less than 300, then adjust the luminance based on the distance simulating the flash light in real life and upload the adjusted luminance on each pixel; if the distance is more than 300, update the room image with the data in its pixels [] array directly. By this method, Processing needs to calculate at each pixel, so the shift of flashlight looks a bit dull especially in high definition.

The PVector is used to describe the two-dimensional vector of class Rain. And create a lot of rain lines at random length between 10 and 70. The starting locations of lines are in random distribution. And the end locations are calculated based on starting coordinates and the sine or cosine of an angle with the length. Also, the increment of location is calculated by the angle between vectors. So it can rain at the same slope and speed.

## Reflection 
Through creating this work, I learned about using the pushMatrix () function to save the current coordinate system to the stack and the popMatrix () to restore the prior coordinate system. I am quite pleased with using translate () to enlarge the house image centered on the door to implement the effect of entering the door. I think the piece could be improved by at least in three ways: First, make the visuals of thundering and lightning synchronize with sound of thunder. Secondly, maybe I could try a new method to make the move of flashlight more smoothly. Thirdly, the puddles in the ground can be drawn.



