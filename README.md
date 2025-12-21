# Tuing RPG

1.0 - Introduction

2.0 - Map Format

3.0 - Todo

4.0 - Ideas once I get through the Todo stuff

9.0 Download Turing and get started programming

### 1.0 - Introduction
This is my version of a simple RPG game with a procedurally generated world. This Readme file is currently as incomplete as the game itself is, and I'm just using it to keep track of random info related to the game and my ideas/progress.

### 2.0 Map Format
Oh man, this is fun. I've pretty much just thrown numbers at the map files as I built the game engine, but I think the format I'm using makes some sense. Yes, I'm sure there's better ways to do it, but this is what I came up with.

The map format consists of 2 char pairs to represent data as follows:
char 000-001 - Map Type
     002-025 - Exit Points
     026-227 - Map Sprites

Map types currently consist of the following types:
00 - Dev maps
01 - Castle/home base maps
10 - Wilderness maps

Exit points are labeled from the top left to the bottom right. Below is a digram showing all current exit points for a map:

    01  02  03
    |   |   |
04--+-------+--05
    |       |
06--|       |--07
    |       |
08--+-------+--09
    |   |   |
    10  11  12

###3.0 Todo

###4.0 Ideas once I get through the Todo stuff

9.0 Download Turing and get started programming
Turing is available for free from [Compsci.ca](http://compsci.ca/holtsoft). This was originally a programming language developed by Ric Holt and partners from the University of Toronto, mainly to be used in computer science courses in Ontario classrooms. Despite being a basic beginner language, Turing can be used for more advanced programs.