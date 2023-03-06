# AssetDash Mobile Engineering Take-home test - Solution

## Getting Started

Flutter app that retrieves data from an API and displays it in a pie chart and a table/list view. The app also allow users to filter the table/list view based on the asset type.


## Screenshot

<img src="images/portfolio-tracker-list.png" width="400"  /> <img src="images/porfolio-tracker-empty-list.png" width="400"  />




## How to Use 

Project Requirements:

The project requires the following components to be installed and configured:

Flutter: The project requires Flutter SDK to be installed on the system. The current version of Flutter installed on the system should be stable, 3.3.4.

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/vickcharles/assetdash-mobile-takehome-main.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run the project 

```
flutter run
```


## Runn the test

```
flutter test
```

## Packages

- [Http](https://pub.dev/packages/http)
- [Mockito](https://pub.dev/packages/mockito)
- [Pie Chart](https://pub.dev/packages/pie_chart)
- [Build_runner](https://pub.dev/packages/pie_chart)


# AssetDash Mobile Engineering Take-home test

Our mission at AssetDash is to help users track the assets in their portfolio from many different sources.

In this exercise, you will be fetching from an API and rendering components to create a screen within our Flutter mobile application. An important module at AssetDash is the portfolio tracking tool,
which pulls in and calculates the user's portfolio holdings across different asset types and displays this to them on the web or in the mobile app.

Please read the instructions below and complete the task at your own pace. It should not take longer than 1 hour for
you to complete the mobile assignment.

## Mobile

Task: You have been provided a backend API and a boilerplate new Flutter project. You will create the screen below by fetching data from the API provided and using any Flutter libraries you would like.

![Mobile Assignment](images/mobile_assignment.png)

Notes

- You can use any Flutter libraries
- If there are any custom instructions for how to run the app please provide them to me so I may run it

UI elements:

- Title - "AssetDash Portfolio Tracker"
- Search bar for User ID
- Portfolio Chart
  - Pie chart showing the breakdown of assets by `type`
- Portfolio Holdings
  - Listview/table showing the list of assets by `type`

UX:

- Screen initially will appear empty since there is no User ID in the search bar
- If you search by User ID in the search bar it should fetch from the endpoints you created in the backend part
- Display the chart using any graphing library you like
- Display the list of holdings as either a table or a listview
- The "Asset Type" dropdown should default to "All" which means no filter.
- When a user change the dropdown it should query the holdings endpoint and filter by `asset type`

Bonus points for making the app look pretty with a nice graphing library styles :)

#### API Endpoint

- Fetch User data API endpoint. This API is passed a `user_id` (string) and returns a JSON array of the list of holdings for that user.

#### Endpoints

- User portfolio holdings endpoint (UserID ranges from 1-20)
  - GET request
  - URL `https://624760d3229b222a3fcc6155.mockapi.io/api/v1/portfolio/[user_id]`
  - E.g., `https://624760d3229b222a3fcc6155.mockapi.io/api/v1/portfolio/2`
  - Query Params
    - `user_id`: `str`
  - Response
    - Return a list of the user's holdings in descending order by value.
    - Example response:
    ```
     [
        {
            "ticker": "AAPL",
            "name": "Apple",
            "type": "stock",
            "value": 1000,
        },
        ...
     ]
    ```
