# Match Score iOS

## Overview

Match score is an app that shows you the upcoming matches of your favorite esport.

This repository contains the Match score iOS app built with SwiftUI and follows the MVVM architecture pattern. It leverages the Combine framework for reactive programming. The app also includes support for data refresh and pagination.

## Features

- MVVM architecture for structured code organization.
- SwiftUI for building the user interface.
- Combine framework for reactive and declarative programming.
- Data refresh: Pull to refresh functionality for updating data.
- Pagination: Load more data as the user scrolls through the content.

## Requirements

- Xcode 12.0+
- iOS 14.0+
- Swift 5.0+

## Installation

1. Clone the repository to your local machine:

   ```shell
       git clone https://github.com/leandrorss/match-score.git
   ```
2. Open the project in Xcode.
3. Add your PandaScore token at the Environment variable scheme PANDA_SCORE_API.
3. Build and run the app on your simulator or physical device.

## Project Structure

The project is structured as follows:

- **API**: Includes services to get api data
- **Network**: Includes network generics api services to fetch and decode 
- **Manager**: Include helper managers 
- **Extension**: Houses the extensions helper classes
- **Util**: Houses the util classes for the app
- **Resources**: Includes the app's resources like colors languages etc
- **Components**: Contains SwiftUI components
- **Views**: Contains SwiftUI views/screens