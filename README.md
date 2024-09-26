# countries_app

This project is a Flutter application that displays a list of Latin American countries, allowing users to add, edit, and delete countries.

## Project Description

The application has three main screens:

- **HomeScreen**: Displays a list of cards, each representing a country.
- **DetailsScreen**: Shows details of the selected country, with options to edit or delete the country.
- **FormScreen**: Allows users to add a new country or edit an existing one.

This project is based on the Clean architecture by separating responsibilities into different layers:

- **Presentation (UI)**: Contains screens. It interacts only with the use cases.
- **Domain**: Contains business rules and use cases. In this layer, use cases interact with the repository interface, unaware of how the data is stored or manipulated.
- **Infrastructure**: Contains the implementation of repositories, managing data access logic, such as loading the JSON file.


