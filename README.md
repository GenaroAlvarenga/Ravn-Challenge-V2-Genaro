# Ravn Code Challenge - V2

This is an iOS mobile app that allows you to browse all the characters in the Star Wars GraphQL API.

## Prerequisites

You need to have Xcode 12.0 or higher

## Installation

Clone the repository using this [link](https://github.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro.git):
```bash
git clone https://github.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro.git
```

## Usage

Open the xcodeproj placed in the main project file.
```bash
Ravn-Challenge-V2-Genaro.xcodeproj
```

Then you will see that the dependencies are gonna start downloading, wait until this process finishes.

![alt text](https://raw.githubusercontent.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro/feature/CreateReadme/Image/Dependencies.png?raw=true)

After this, you can select your favorite simulator and build and run the `Ravn-Challenge-V2-Genaro` Scheme.

The simulator is going to pop up, and you will see a list of people from the Star Wars saga

![alt text](https://raw.githubusercontent.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro/feature/CreateReadme/Image/People.png?raw=true)

You can select one character and read the detail of this character.

![alt text](https://raw.githubusercontent.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro/feature/CreateReadme/Image/Detail.png?raw=true)

## File Tree

The project is divide by:
- Models
   All the models used to represent the data in the views
- Services
   All the services used in the app like the services used to fetch the info from the API and return to the view models.
- Modules
  - People
    The view and view model to represent the list of characters in the Wars GraphQL API.
  - PeopleDetail
    The view and view model to represent the detail of a character.
- Network
  The API connection

![alt text](https://raw.githubusercontent.com/GenaroAlvarenga/Ravn-Challenge-V2-Genaro/feature/CreateReadme/Image/FileTree.png?raw=true)

