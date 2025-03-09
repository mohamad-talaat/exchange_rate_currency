# Currency Exchange App

A Flutter application that allows users to interact with a currency exchange API. Users can select a time range and currencies to view historical exchange rates.

## Features

- Select base and target currencies
- Choose a date range for historical data
- View exchange rates in a paginated table (10 rows per page)
- Navigate between pages of results

## Architecture

The application follows the MVC (Model-View-Controller) pattern with GetX for state management:

- **Models**: Define data structures for API responses and display data
- **Views**: UI components that display data to the user
- **Controllers**: Handle business logic and state management

## Libraries Used

- **GetX**: State management, dependency injection
- **HTTP**: API communication
- **Intl**: Date formatting

## API

The application uses the Exchange Rate API from exchangerate.host:

- Base URL: <https://api.exchangerate.host>
- Endpoint: /timeframe

## Setup Instructions

1. Make sure you have Flutter installed
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Code Structure

- `lib/main.dart`: Entry point of the application
- `lib/models/`: Data models
- `lib/controllers/`: Business logic and state management
- `lib/services/`: API communication
- `lib/views/`: UI components

## Design Decisions

- Used GetX for state management to keep the code clean and organized
- Implemented pagination in-memory to reduce API calls
- Created a reusable UI components for currency and date selection
- Used MVC pattern for better code organization and maintenance