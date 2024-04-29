# HealthApp
# UICollectionView Lazy Loading Implementation

This project demonstrates the implementation of lazy loading for images in a UICollectionView using Swift. Lazy loading ensures that images are loaded asynchronously as they become visible on the screen, improving performance and reducing memory usage.

## Overview

The project consists of the following components:

1. **ImageListViewController**: This view controller contains a UICollectionView to display a grid of images. It fetches image data from a service and populates the collection view with image cells.

2. **ImageCell**: A custom UICollectionViewCell subclass responsible for displaying images. It handles the asynchronous loading of images and ensures that only visible images are loaded.

3. **ImageListViewModel**: The view model responsible for fetching image data from the service and providing it to the view controller. It uses an ImageLoader to fetch images asynchronously.

4. **ImageLoader**: A service class responsible for loading images asynchronously from URLs. It utilizes caching mechanisms to improve performance and efficiency.

5. **AlertView**: A utility struct for displaying alerts. It provides a static method for showing alerts on the main thread.

## Features

- Asynchronous image loading: Images are loaded asynchronously to prevent blocking the main thread and ensure smooth scrolling.
- Memory and disk caching: Images are cached in memory and on disk to improve performance and reduce network requests.
- Lazy loading: Images are loaded lazily as they become visible on the screen, minimizing unnecessary loading and improving scrolling performance.
- Error handling: Network errors and image loading failures are gracefully handled.

## Setup and Usage

1. Clone the repository to your local machine.
2. Open the Xcode project file.
3. Build and run the project on a simulator or device.

## Dependencies

- None
